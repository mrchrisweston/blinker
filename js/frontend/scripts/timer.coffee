$ ->
	# Timers, made global so every function has access to it
	twentyMinInterval = null
	twentySecInterval = null

	setTwentySecInterval = () =>
		console.log '20 sec break'
		# The 20 mins has come to an end
		clearInterval(twentyMinInterval)

		# Add class to open the eye
		$('#eye_area').addClass('eye-area--open')

		# Set 20 second timer
		twentySecInterval = setInterval (->
		  setTwentyMinInterval()
		  return
		), 20000

	setTwentyMinInterval = () =>
		console.log 'Start twenty mins'
		# Clear the 20 sec timer
		clearInterval(twentySecInterval)

		# Close eye
		$('#eye_area').removeClass('eye-area--open')

		# After 20 minutes execute function
		twentyMinInterval = setInterval (->
		  setTwentySecInterval()
		  return
		), 1200000

	StopAllTimers = (showStart) =>
		# Stop all timers
		clearInterval(twentyMinInterval)
		clearInterval(twentySecInterval)
		twentyMinInterval = null
		twentySecInterval = null

		# If the timer was not already running then do nothing
		unless $('body').hasClass('active')
			return

		console.log 'timers stopped'

		# Reset to show the Start button
		$('#eye_area').fadeOut(300, () ->

			# Display Start button
			if showStart
				$('#start').fadeIn(300)
			)

		# Flag timer has stopped
		$('body').removeClass('active')

	# User has stopped the timer
	$('.controls .player').bind 'click', (ev) =>
		# Stop all timers
		StopAllTimers(true)

	# Hide the intro message and display the Start button
	$('.close-what').bind 'click', (ev) ->
		ev.preventDefault()
		$('#what').addClass('what--hidden')
		$('#what').fadeOut(300, () ->

			# Display Start button
			$('#start').fadeIn(300)
			)

	# User presses the Start button, begin timer
	$('#start .text').bind 'click', (ev) ->
		$('#start').fadeOut(300, () ->

			# Display the eye
			$('#eye_area').fadeIn(300)
			)
		
		# Start the 20 min timer
		setTwentyMinInterval()

		# Flag if timer is running
		$('body').addClass('active')

	# Display the info and stop the timer
	$('.info').bind 'click', (ev) ->

		# If What is displayed do nothing
		if $('#what').is(':visible')
			console.log 'return'
			return

		StopAllTimers(false)

		# Start is showing
		if $('#start').is(':visible')
			console.log 'start visible'
			$('#start').fadeOut(300, () ->

				# Display the What info
				$('#what').fadeIn(300)
				)
		# Eye is showing
		else
			console.log 'eye visible'
			$('#eye_area').fadeOut(300, () ->

				# Display the What info
				$('#what').fadeIn(300)
				)
