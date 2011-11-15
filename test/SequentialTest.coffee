
assert = require 'assert'
each = require '../index'

module.exports = 
    'Chain # array': (next) ->
        current = 0
        each( [ {id: 1}, {id: 2}, {id: 3} ] )
        .on 'data', (n, element) ->
            current++
            assert.eql current, element.id
            setTimeout n, 100
        .on 'end', ->
            assert.eql current, 3
            next()
    'Chain # array # send error': (next) ->
        each( [ {id: 1}, {id: 2}, {id: 3} ] )
        .on 'data', (n, element) ->
            if element.id is 2
                n( new Error 'Testing error' )
            else setTimeout n, 100
        .on 'error', (err) ->
            assert.eql 'Testing error', err.message
            next()
    'Chain # object': (next) ->
        current = 0
        each( {id_1: 1, id_2: 2, id_3: 3} )
        .on 'data', (n, key, value) ->
            current++
            assert.eql "id_#{current}", key
            assert.eql current, value
            setTimeout n, 100
        .on 'end', ->
            assert.eql current, 3
            next()
    'Chain # undefined': (next) ->
        current = 0
        each( undefined )
        .on 'data', (n, element) ->
            current++
            assert.eql undefined, element
            setTimeout n, 100
        .on 'end', ->
            assert.eql current, 1
            next()
    'Chain # null': (next) ->
        current = 0
        each( null )
        .on 'data', (n, element) ->
            current++
            assert.eql null, element
            setTimeout n, 100
        .on 'end', ->
            assert.eql current, 1
            next()
    'Chain # string': (next) ->
        current = 0
        each( 'id_1' )
        .on 'data', (n, element) ->
            current++
            assert.eql "id_1", element
            setTimeout n, 100
        .on 'end', ->
            assert.eql current, 1
            next()
    'Chain # number': (next) ->
        current = 0
        each( 3.14 )
        .on 'data', (n, element) ->
            current++
            assert.eql 3.14, element
            setTimeout n, 100
        .on 'end', ->
            assert.eql current, 1
            next()
