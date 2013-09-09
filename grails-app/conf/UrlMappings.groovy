class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller:"application", action:"index")
		"500"(view:'/error')
		
		"/confirm/$token?"(controller:"application", action:"confirm")
		"/resetPassword/$token?"(controller:"application", action:"resetPassword")
		"/data/$token?/$restOfUrl**"(controller:"application", action: "data")
		"/data2/$restOfUrl**"(controller:"application", action:"data2")
	}
}
