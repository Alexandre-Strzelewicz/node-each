
    var each = require('each');
    
    // With an `end_callback` in `parallel` mode:
    
    each([
        {id: 1},
        {id: 2},
        {id: 3}
    ], true, function(id, next) {
        if(next === null) return done();
        console.log('id: ', id);
        setTimeout(next, 500);
    }, function(){
        console.log('Done');
    });