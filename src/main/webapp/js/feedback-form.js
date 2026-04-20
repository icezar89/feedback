$(function () {
    var $message = $('#message');
    var updateCount = function () {
        $('#messageCount').text($message.val().length);
    };
    $message.on('input', updateCount);
    updateCount();

    $('form').on('submit', function (event) {
        var emailInput = $('#email')[0];
        if (emailInput.value && !emailInput.checkValidity()) {
            event.preventDefault();
            toastr.error($('body').attr('data-email-invalid-message'));
        }
    });

    toastr.options = {
        closeButton: true,
        progressBar: true,
        positionClass: 'toast-top-right',
        timeOut: 3500
    };

    var notificationType = $('body').attr('data-notification-type');
    var notificationMessage = $('body').attr('data-notification-message');
    if (notificationType && notificationMessage) {
        toastr[notificationType](notificationMessage);
    }
});
