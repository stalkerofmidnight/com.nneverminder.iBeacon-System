//
//  HomeVM.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/31/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import FirebaseFunctions
import ObjectMapper

protocol HomeVMDelegate: class {
    func homeVM(didLoad students: [Student])
    func homeVM(didRecieveError message: String)
    func homeVM(didChange state: LoadingState)
}

class HomeVM {
    
    weak var delegate: HomeVMDelegate?
    
    var students: [Student] = [] {
        didSet {
            self.delegate?.homeVM(didLoad: students)
        }
    }
    
    func load(for date: Date) {
        
        delegate?.homeVM(didChange: .overlay)
        students = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        
        Functions.functions().httpsCallable("getUsers").call(["date": dateFormatter.string(from: date)]) { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.homeVM(didRecieveError: error.localizedDescription)
            } else if let json = result?.data as? [[String: Any]] {
                self.students = Mapper<Student>().mapArray(JSONArray: json).sorted(by: { $0.isExist && !$1.isExist })
            }
            self.delegate?.homeVM(didChange: .idle)
        }
        
    }
}
