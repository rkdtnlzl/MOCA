//
//  Todo.swift
//  MOCA
//
//  Created by 강석호 on 9/18/24.
//

import Foundation
import RealmSwift

final class Todo: Object, ObjectKeyIdentifiable  {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var complete: Bool
    
    convenience init(title: String, complete: Bool = false) {
        self.init()
        self.title = title
        self.complete = complete
    }
}
