module.exports = (grunt) ->

    # Project configuration.
    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json')

        coffee:
            frontend:
                files:
                    'frontend/scripts/tmp/timer.js': [
                        'frontend/scripts/site.coffee'
                    ]

        concat:
            frontend:
                files:
                    '<%= pkg.www %>/scripts/timer.js': [
                        'vendor/scripts/jquery-2.1.4.min.js'
                        'frontend/scripts/tmp/timer.js'
                        ]

        clean:
            [
                'frontend/scripts/tmp'
                'vendor/scripts/tmp'
            ]

        watch:
            scripts:
                files: ['frontend/scripts/*.coffee'],
                tasks: ['scripts']
    })

    # Plugins
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    # Tasks

    # Tasks - Frontend
    grunt.registerTask 'scripts', [
        'coffee:frontend'
        'concat:frontend'
        'clean'
        ]

    grunt.registerTask 'watch-scripts', [
        'watch:scripts'
    ]

    grunt.registerTask 'production', [
        'coffee',
        'concat',
        'clean'
    ]