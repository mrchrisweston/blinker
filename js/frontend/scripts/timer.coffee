$ ->
	TriggerNotification = () =>
		if Notification
			console.log 'run notification!'

			notification = new Notification('Blinker',
				body: 'Take a break from the screen!')

	# Timers, made global so every function has access to it
	twentyMinInterval = null
	twentySecInterval = null

	setTwentySecInterval = () =>
		# The 20 mins has come to an end
		clearInterval(twentyMinInterval)

		# Add class to open the eye
		$('#eye_area').addClass('eye-area--open')

		# Fire off the alert sound
		$('.alert-sound').trigger('play')

		# fire off notification
		TriggerNotification()

		# Set 20 second timer
		twentySecInterval = setInterval (->
		  setTwentyMinInterval()
		  return
		), 20000

	setTwentyMinInterval = () =>
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

		# Reset to show the Start button
		$('#eye_area').fadeOut(300, () ->

			# Display Start button if specified
			if showStart
				$('#start').fadeIn(300)

			# If "what" is showing hide it
			if $('#what').is(':visible')
				$('#what').fadeOut(300)
			)

		# Flag timer has stopped
		$('body').removeClass('active')

	# User has stopped the timer
	$('.controls .player').bind 'click', (ev) =>
 
		# Make sure the "what" text is reset
		if $('body').hasClass('active')
			$('.info a').text('What the what?')

		# Stop/Start timer
		if $('body').hasClass('active')
			$('.controls .player').css('background-image', 'url("../img/play.png")')
			$('#start').show()
			StopAllTimers()
		else
			$('#start .text').trigger('click')

	# Hide the intro message and display the Start button
	$('.close-what').bind 'click', (ev) ->
		ev.preventDefault()
		$('#what').addClass('what--hidden')
		$('#what').fadeOut(300, () ->

			# Reset 'what the what' text
			$('.info a').text('What the what?')		

			# Timer already running, show eye
			if $('body').hasClass('active')
				$('#eye_area').fadeIn(300)

			# Timer not running, show start button
			else
				$('#start').fadeIn(300)
			)

	# User presses the Start button, begin timer
	$('#start a').bind 'click', (ev) ->
		$('#start').fadeOut(300, () ->

			# Display the eye
			$('#eye_area').fadeIn(300)
			)

		# ask for notification permission
		if !Notification
			console.log('permission not granted')
			Notification.requestPermission()
		else
			console.log 'permission granted'
		
		# Start the 20 min timer
		setTwentyMinInterval()

		# Flag if timer is running
		$('body').addClass('active')

		# Update controls icon
		$('.controls .player').css('background-image', 'url("../img/stop.png")')

	# Display the info and stop the timer
	$('.info').bind 'click', (ev) ->

		# If What is displayed do nothing
		if $('#what').is(':visible')
			$('.close-what').trigger('click')
			$('.info a').text('What the what?')
			return

		# Change "What" text to say "Hide" when open
		$('.info a').text('close')

		# Start is showing
		if $('#start').is(':visible')
			$('#start').fadeOut(300, () ->

				# Display the What info
				$('#what').fadeIn(300)
				)
		# Eye is showing
		else
			$('#eye_area').fadeOut(300, () ->

				# Display the What info
				$('#what').fadeIn(300)
				)

	# Notification permission
	console.log 'ask permission'
	if Notification.permission != 'granted'
		console.log('not yet granted')
		Notification.requestPermission()
	else
		console.log('already granted')
	return


