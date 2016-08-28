$ ->
    # Timers, made global so every function has access to them
    twentyMinInterval = null
    twentySecInterval = null

    usersFirstVisit = () ->
        # If it's the user's first visit then display
        # what the waht message automatically.
        if not localStorage.getItem('hasVisitedBefore')

            # Trigger what the what
            $('.info').trigger('click')

            # Set local storage
            localStorage.setItem('hasVisitedBefore', 'true')

    triggerTwentyMinsSound = () =>
        console.log 'min sound'
        $('.alert-sound').trigger('play')

    triggerTwentySecondSound = () =>
        console.log 'second sound'
        $('.alert-sound').trigger('play')

    triggerNotification = () =>
        if Notification
            notification = new Notification('Blinker',
                body: 'Take a break from the screen!')

    setTwentySecInterval = () =>
        # The 20 mins has come to an end
        clearInterval(twentyMinInterval)

        # Eye open
        $('.eye-open').show()
        $('.eye-closed').hide()

        # Fire off the alert sound, if the user hasn't
        # muted it.
        if not $('body').hasClass('muted')
            triggerTwentyMinsSound()

        # fire off notification
        triggerNotification()

        # Set 20 second timer
        twentySecInterval = setInterval (->
            
            # Fire off the alert sound, if the user hasn't
            # muted it.
            if not $('body').hasClass('muted')
                triggerTwentySecondSound()

            setTwentyMinInterval()
            return
        ), 20000

    setTwentyMinInterval = () =>
        # Clear the 20 sec timer
        clearInterval(twentySecInterval)

        # Eye closed
        $('.eye-open').hide()
        $('.eye-closed').show()

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
            $('#start a').trigger('click')

    # Mute/unmute the sound from firing after 20 mins has elapsed
    $('.controls .sound').bind 'click', (ev) =>

        if $('body').hasClass('muted')
            $('body').removeClass('muted')
            $('.controls .sound').css('background-image', 'url("../img/volume-full.png")')
        else
            $('body').addClass('muted')
            $('.controls .sound').css('background-image', 'url("../img/mute.png")')

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
            Notification.requestPermission()
        
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
    if Notification.permission != 'granted'
        Notification.requestPermission()

    usersFirstVisit()


