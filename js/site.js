// Common site Jquery.

$(function() {

    // Check if device supports touch events, and consequently is most likely a touch device rather than a desktop.
    var supportsTouch = 'ontouchstart' in window || navigator.msMaxTouchPoints;

    // Mobile navigation.
    var navItemAreas = $('#nav');
    $(navItemAreas).click(function (ev) {
        ev.stopPropagation();
        if ($(this).hasClass('on')) {
            $(navItemAreas).removeClass('on');
            $(this).removeClass('on');
            $(navItemAreas).find('.on').removeClass('on');
        } else {
            $(navItemAreas).removeClass('on');
            $(this).addClass('on');
        }
    });
    $(document).click(function () {
        $(navItemAreas).removeClass('on').find('.on').removeClass('on');
    });
});