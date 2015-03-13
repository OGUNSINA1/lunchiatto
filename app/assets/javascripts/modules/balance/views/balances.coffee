@CodequestManager.module "Balance", (Balance, App, Backbone, Marionette, $, _) ->
  Balance.Balances = Marionette.CompositeView.extend
    template: "balances/balances"
    getChildView: ->
      Balance.Balance
    childViewContainer: ".balances-container"

    templateHelpers: () ->
      total: @collection.total()
      type: @collection.type

    collectionEvents:
      "sync": "render"

    initialize: ->
      @type = @options.type
      App.vent.on "reload:finances", =>
        @collection.fetch()