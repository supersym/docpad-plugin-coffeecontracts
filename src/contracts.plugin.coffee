
###
@mixin
Defines common classes, properties and (helper) methods for enablement of the coffee-contracts dialect.
Expose the plugin properties and methods to outside
###
module.exports = (BasePlugin) ->

  # Defines a blueprint for the coffeescript contracts dialect as plugin
  class CoffeeContractsPlugin extends BasePlugin

    # @property [String] The name of this plugin
    name: 'coffeecontracts'

    ###
    #### Renders source code in CoffeeScript to JavaScript
    @property options [Object] A object to hold our settings
    @param opts [Options] A object to hold our options
    @param next [Callback] The next rendering object in queue
    ###
    renderCoffeeScriptToJavaScript: (opts,next) ->

      # @private content [Options] Prepare local member variable object
      {content} = opts

      # @require [Package] CoffeeScript
      coffee = require('coffee-script')
      contracts = require('contracts.coffee')

      # @function Render content of the file
      opts.content = coffee.compile(content)

      next()


    # Render event called per document, for each extension conversion. Used to render one extension to another.
    render: (opts,next) ->

      # Set local member variable values
      {inExtension,outExtension} = opts

      # CoffeeScript to JavaScript condition
      if inExtension is 'coffee' and outExtension in ['js',null]

        # Render CoffeeScript to JavaScript and complete
        @renderCoffeeScriptToJavaScript(opts,next)

      # No proper extension
      else

        # Nothing to do
        return next()
