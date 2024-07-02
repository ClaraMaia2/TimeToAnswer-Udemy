import { Application } from "@hotwired/stimulus"
import jQuery from "jquery"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
export { jQuery }
