databaseChangeLog = {

	changeSet(author: "gturnquist (generated)", id: "1365091291391-1") {
		addColumn(tableName: "user") {
			column(name: "when_password_reset_hash_code_was_issued", type: "datetime")
		}
	}

	changeSet(author: "gturnquist (generated)", id: "1365091291391-2") {
		dropNotNullConstraint(columnDataType: "datetime", columnName: "when_password_reset_hash_code_was_issued", tableName: "user")
	}
}
