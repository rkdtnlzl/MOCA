//
//  Moca.swift
//  MOCA
//
//  Created by 강석호 on 9/19/24.
//

import SwiftUI
import RealmSwift

final class Moca: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var createAt: Date
    @Persisted var images: RealmSwift.List<Data>
    @Persisted var cafeLocation: String
    @Persisted var todos: RealmSwift.List<Todo>

    convenience init(createAt: Date, images: [Data], cafeLocation: String, todos: [Todo]) {
        self.init()
        self.createAt = createAt
        self.cafeLocation = cafeLocation
        self.images.append(objectsIn: images)
        self.todos.append(objectsIn: todos)
    }
}
