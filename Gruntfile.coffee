module.exports = (grunt) ->
	grunt.initConfig
		coffee:
			compile:
				files: "build/js/app.js": "src/app/application.coffee"
		compass:
			dist:
				options:
					config: 'config/compass-config.rb'
		watch:
			options:
				livereload: true
			css:
				files: ["src/sass/**/*.sass"]
				tasks: ["compass"]
			js:
				files: ["src/app/**/*.coffee"]
				tasks: ["coffee"]
		concat:
			options:
				stripBanners: true
				separator: ";\n"
			dist:
				src: ['src/vendor/plugins.js','build/js/app.js']
				dest: 'build/js/app.js'
		copy:
			main:
				files: [
					src:
						['src/index.html']
					dest:
						'build/index.html'
				]
		uglify:
			dist:
				files:
					'src/vendor/plugins.js': ['src/vendor/modernizr.js', 'src/vendor/jquery.js']
		main:
			production: true

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-compass'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-contrib-uglify'

	grunt.registerTask 'default', 'Concat vendor on top of app.js', () ->
		grunt.task.run ['coffee', 'uglify', 'concat:dist', 'compass', 'copy']

	true