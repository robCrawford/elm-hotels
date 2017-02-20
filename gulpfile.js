var gulp = require('gulp');
var elm = require('gulp-elm');
var spawn = require('child_process').spawn;

function onError(err) {
    console.log(err.toString());
    this.emit('end');
}

gulp.task('elm', function () {
    return gulp.src('src/Main.elm')
        .pipe(elm())
        .on('error', onError)
        .pipe(gulp.dest('public/js/'));
});

gulp.task('default', function () {
    var process = spawn('node', ['app.js'], { stdio: 'inherit' });
    console.log('PID: ', process.pid);
    gulp.watch('src/*.elm', ['elm']);
});
