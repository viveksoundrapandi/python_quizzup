$(document).ready(function()
{
    $('.box-body').on('click', '#take-quiz', function()
    {
        window.location.href = $(this).data('redirect-to');
    });
    var form_obj = $('form');
    if(form_obj.length)
        form_obj.validator();
    var questions = $(".questions");
    if(questions.length)
    {
        $(" .questions input[type='radio']").on('ifChanged', function(event) {
            questions.hide();
            var next_question = $(this).closest('.questions').next();
            if (next_question.index() != -1)
                next_question.show();
            else
            {
                $('#quiz-form').submit();
            }
        });
    }
});
