$(document).ready(function()
{
    var form_obj = $('form');
    var questions = $('.questions');
    var progress_bar = $('#progressTimer');
    var question_title = $('#question_title');
    var question_counter = 2;
    var submitted = false;
    var text_timer = $('#text_timer');
    function show_modal()
    {
        var hash = window.location.hash.slice(1);
        if( hash && hash === 'rules-modal' ) {
            $('#' + hash).modal('show');
        };
    }
    function show_next_question(current_question)
    {
        var closest = current_question.closest('.questions');
        closest.find(':hidden').eq(0).val(time_remaining);
        var next_question = closest.next();
                questions.hide();

        setTimeout(function() {
                locked = false;
                setTimeout(function() {
                    if (next_question.index() != -1)
                    {
                        question_title.text('Question ' + question_counter++);
                        next_question.show();
                        time_remaining = 0;
                        progress_bar.html('<div class="progress xs active progress-striped"><div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="12" width="100%" style="width: 100%;"></div></div>');
                        enable_progress_timer();
                    }
                    else
                    {
                        submitted=false;
                        $('#quiz-form').submit();
                    }
                }, 1000);
            }, 600);
    }
    function enable_text_timer()
    {
        var timeout = +questions.filter(':visible').find(':hidden').eq(1).val();
        text_timer.countdown({
        date: +(new Date) + timeout*1000,
        render: function(data) {
          $(this.el).text(this.leadingZeros(data.sec, 2) + ' seconds');
        },
        onEnd: function() {
          $(this.el).addClass('ended');
        }
      });
    }
    function reset_text_timer(timeout)
    {
        text_timer.removeClass('ended').data('countdown').update(+(new Date) + timeout*1000).start();
    }
    function enable_progress_timer()
    {
        var timeout = +questions.filter(':visible').find(':hidden').eq(1).val();
        console.log(timeout);
        progress_bar.progressTimer({
            timeLimit: timeout,
            warningThreshold: 7,
            dangerThreshold: 10,
            baseStyle: 'progress-bar-success',
            warningStyle: 'progress-bar-warning',
            completeStyle: 'progress-bar-danger',
            onFinish: function() {
                if(!locked)
                {
                time_remaining = 0;
                show_next_question(questions.filter(':visible'));
                }
            }
        });
        reset_text_timer(timeout);
    }
    function inject_native_window()
    {
        $('.cancel_submit').live('click',function (e){
            submitted=true;
        });

        window.onbeforeunload = function()
        {
            if(!submitted)
            {
                str = 'Closing your browser window will terminate the current quiz and you can never comeback to this week's quiz :(';
            return str;
            }
                    submitted=false;
        }

    }
    $('.box-body').on('click', '#take-quiz', function()
    {
        window.location.href = $(this).data('redirect-to');
    });
    var form_obj = $('form');
    if(form_obj.length)
        form_obj.validator();
    var questions = $('.questions');
    if(questions.length)
    {
        enable_text_timer(); 
        $(' .questions input[type='radio']').on('ifChanged', function(event) {
            locked = true;
            window.clearInterval(interval);
            show_next_question($(this));
        });
        enable_progress_timer();
    }
    var username = $('#username');
    if(username.length)
    {
        username.on('blur', function(){
            $(this).next().text('');
        });
    }
    show_modal();
    $('form').on('click', '#register-submit', function()
    {
        ga('send', 'event', 'form', 'submit', 'Registration-Complete');
    });
});
