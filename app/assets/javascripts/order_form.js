//validate phone
var phone = $('input[name="phone"]').val(),
    intRegex = /[0-9 -()+]+$/;
if((phone.length < 6) || (!intRegex.test(phone)))
{
     alert('Please enter a valid phone number.');
     return false;
}
