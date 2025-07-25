require_relative './controller/controller'
require_relative './UI/UI'

controller = Controller.new
ui = UI.new(controller)
ui.run
