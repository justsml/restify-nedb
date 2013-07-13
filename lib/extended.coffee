_ = require "underscore"

# extend nedb to give us a Schema we can generate easily with a stale timestamp
# this will allow us to do a very simpe garbage collection for these `temporary`
# objects
extended = (ds) ->

  _.extend @, ds

  ds.loadDatabase (err) ->
    return if err? then throw err
    # run this once, because it's okay.
    ds.remove {stale: {$lt: Date.now()}}, {multi: true}, (err, removed) ->
      if removed > 0
        console.log "NeDB: sent #{removed} items to garbarge collection"
  
    setInterval ->
        ds.remove {stale: {$lt: Date.now()}}, {multi: true}, (err, removed) ->
          if removed > 0
            console.log "NeDB: sent #{removed} items to garbarge collection"
    , 1000 * 60 * 10 # setting this to ten minute increments should do the trick.

  @

# Schema takes opts, and you can really extend that to as large as you'd like
extended::Schema = (opts) ->

  stale = 1000 * 60 * 60
  
  @stale = stale
  
  garbageCollection = (stale) ->
    ds.remove {stale: {$lt: Date.now()}}, {multi: true}, (err) ->
      return if err? then throw err

  @store = undefined
  
  if opts? then _.extend @, opts

  self = @

  if @stale? or @stale != false
    setTimeout ->
      garbageCollection self.stale
    , self.stale

    @stale = Date.now() + self.stale
  else
    @stale = undefined

  @

module.exports = extended
