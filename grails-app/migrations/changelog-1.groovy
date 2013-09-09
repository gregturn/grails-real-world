databaseChangeLog = {

	changeSet(author: "gturnquist (generated)", id: "1365084632007-1") {
		addColumn(tableName: "user") {
			column(name: "when_confirmation_hash_code_was_issued", type: "datetime")
		}
	}

	changeSet(author: "gturnquist (generated)", id: "1365084632007-4") {
		dropNotNullConstraint(columnDataType: "datetime", columnName: "when_confirmation_hash_code_was_issued", tableName: "user")
	}

	changeSet(author: "gturnquist (generated)", id: "1365084632007-2") {
		addForeignKeyConstraint(baseColumnNames: "role_id", baseTableName: "user_role", constraintName: "FK143BF46ACFD1663E", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "role", referencesUniqueColumn: "false")
	}

	changeSet(author: "gturnquist (generated)", id: "1365084632007-3") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "user_role", constraintName: "FK143BF46A74FC2A1E", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}
}
