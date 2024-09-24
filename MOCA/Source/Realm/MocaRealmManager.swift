//
//  MocaRealmManager.swift
//  MOCA
//
//  Created by 강석호 on 9/22/24.
//

import SwiftUI
import RealmSwift

class MocaRealmManager: ObservableObject {
    @Published var mocaData: [Moca] = []
    
    init() {
        loadMocaData()
    }
    
    func loadMocaData() {
        let realm = try! Realm()
        let results = realm.objects(Moca.self)
        mocaData = Array(results)
        print("Loaded Moca data: \(mocaData)")
    }
    
    func deleteMoca(_ moca: Moca) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(moca)
        }
        loadMocaData()
    }
}
