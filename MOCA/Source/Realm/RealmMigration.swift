//
//  RealmMigration.swift
//  MOCA
//
//  Created by 강석호 on 9/22/24.
//

import Foundation
import RealmSwift

func setupRealmMigration() {
    let config = Realm.Configuration(
        schemaVersion: 1,
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: Moca.className()) { oldObject, newObject in
                    let oldImages = oldObject?["images"] as? List<Data>
                    let newImages = newObject?["images"] as? List<Data?>
                    oldImages?.forEach { imageData in
                        newImages?.append(imageData)
                    }
                }
            }
        }
    )
    Realm.Configuration.defaultConfiguration = config
}
