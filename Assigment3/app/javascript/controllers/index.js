import {Application} from "@hotwired/stimulus"
import FilterController from "./filter_controller"
const application = Application.start()
application.register("filter", FilterController)
