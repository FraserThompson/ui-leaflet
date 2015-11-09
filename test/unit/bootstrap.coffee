window.ngLeafLetTestGlobals = {}

afterEach ->
    window.doTestLog = false

beforeEach ->

    angular.module('ui-leaflet')
    .config ($provide) ->
        if window.doTestLog
            $provide.value('$log', console)
        $provide.decorator '$timeout', ($delegate, $browser) ->
            $delegate.hasPendingTasks = ->
                $browser.deferredFns.length > 0

            $delegate
    .run (leafletLogger) ->
        leafletLogger.currentLevel = leafletLogger.LEVELS.debug

    @digest = (scope, fn) ->
        while ngLeafLetTestGlobals?.$timeout?.hasPendingTasks()
            ngLeafLetTestGlobals.$timeout.flush()

        fn() if fn?
        scope.$digest() unless scope.$$phase
