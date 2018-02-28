//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require cocoon
//= require chosen-jquery
//= require moment
//= require bootstrap-datetimepicker
//= require sortable-rails-jquery
//= require jquery-ui
//= require jquery.transit.min
//= require select2-full
//= require login

// require tether.min
//= require tablesort
//= require jquery.scrollbar.min
//= require jquery.contextMenu.min
//= require jquery.ui.position.min
//= require comment
//= require todo
//= require_tree .

// function saveComment(){
//   $(this).parents('.form-hidden-comment').remove();
//   $(this).parents('.comment-control').show();
//   $(this).parents('.comment-user-content').show();
// }
//show pass
$('.check-box-password').find('span').on('click', function() {
  selector = $('.password.optional.speed-input.speed-password');
  if (selector.attr('type') === "password") {
    $('.password.optional.speed-input.speed-password').removeAttr("type");
  } else {
    $('.password.optional.speed-input.speed-password').attr("type", "password");
  }
})

function toggleMenuTeam() {
  // console.log('toggleMenuTeam');
  // $('.dropdown-speed').on('click', function(){
  // 	$(this).find('ul.dropdown-menu-speed').toggleClass('hide');
  // })
}

function displayIconMenuTeam() {
  url = window.location.pathname
  var regexp = /teams/gi;
  if (url.match(regexp)) {
    $('span.teams.icon-gly.glyphicon.glyphicon-triangle-top.icon-triagle-top').css({'display': 'block'})
  }
}
function addClassActiveMenu() {

  var items = $('.speed-header .bottom-header').find('.item-container').on('click', function() {

    $(this).find('li.col-md-2.item.active').removeClass('active');
    $(this).addClass('active');
  })
}

function removeEmptyTeamPage() {
  url = window.location.pathname
  var regexp_todolist = /teams\/\d$/gi;
  if (url.match(regexp_todolist)) {
    selector = $('left-container').find('ul').first().find('li').first().find('a');

    if (selector.length) {
      var url_reload = selector.attr('href');
      window.location = url_reload;
    }

  }
}
function removeEmptyWorkloadPage() {
  //go to wf first
  var regexp_workflow = /teams\/\d\/workflows$/gi;
  if (url.match(regexp_workflow) && window.location.search.substring(1) == "") {

    selector = $('left-container').find('ul').first().find('li').first().find('a');
    if (selector.length) {
      var url_reload = selector.attr('href');
      window.location = url_reload;
    }
  }
}
function removeEmptyChecklistPage() {
  //go to check list first
  var regexp_checklist = /teams\/\d\/check_lists$/gi;
  if (url.match(regexp_checklist) && window.location.search.substring(1) == "") {
    selector = $('left-container').find('ul').first().find('li').first().find('a');
    if (selector.length) {
      var url_reload = selector.attr('href');
      window.location = url_reload;
    }
  }
}
function activeTabDueSoon() {
  $('ul.speed-tabs li').click(function() {
    var tab_id = $(this).attr('data-tab');

    $('ul.speed-tabs li').removeClass('current');
    $('.speed-tabs-content').removeClass('current');

    $(this).addClass('current');
    $("#" + tab_id).addClass('current');
  });
}
function activeItemMenubottom() {
  var pathname = window.location.pathname;
  // console.log(pathname);

  var items = $('.speed-header .bottom-header').find('.item-container');
  // console.log(items);
  items.find("li a").each(function(index) {
    var uri_item = $(this).attr('href');
    if (pathname == uri_item) {
      items.find('li').removeClass('active');
      $(this).parent().addClass('active');
    }
  });

  var str = pathname;
  var regexp = /\/\w*/gi;
  var matches_array = pathname.match(regexp);
  var match_uri = matches_array[0];

  var menu = $('.header-middle-container').find('.item');
  menu.find('.item-current').each(function(index) {
    var uri = $(this).data('uri');
    if (match_uri == uri) {
      menu.find('.icon-gly').removeClass('active');
      $(this).parent().find('.icon-gly').addClass('active');
    } else if (match_uri == '/') {
      menu.find('.icon-gly').removeClass('active');
      menu.find('.todos').addClass('active');
    }
  });
}

function setWidthTodoName() {
  var total_width = $('right-container').find('.row.today-task-items.limit-width-tast-todolist-show').outerWidth();
  console.log(total_width);
  $('right-container').find('.task-item').each(function() {
    var todo_name_selector = $(this).find('a.todo-name.one-line-text.todo-limit-width');
    var todo_name_width = todo_name_selector.outerWidth();
    // console.log(todo_name_width);

    var todo_user_width = $(this).find('span.task-member.team').outerWidth();
    // console.log(todo_user_width);

    var deadline_width = $(this).find('span.task-deadline').outerWidth();
    // console.log(deadline_width);

    var box_width = $(this).find('span.cr.todos').outerWidth();
    // console.log(box_width);

    var dot_width = $(this).find('.glyphicon.glyphicon-option-vertical.icon-menu-task').outerWidth();
    // console.log(dot_width);

    var total = todo_name_width + todo_user_width + deadline_width + box_width + dot_width;
    // console.log(total)
    if (total > total_width) {
      // console.log('change ' + $(this));
      var set_width = total - (todo_user_width + todo_user_width);
      todo_name_selector.width(set_width);
      console.log('set_width: ' + set_width);
    }
  })
};

function setColorTodoName() {
  let pathname = window.location.pathname;
  // console.log('pathname: '+ pathname);
  $('left-container .today-task-items.submenu .todo-name').each(function() {
    var href = $(this).attr('href');
    // console.log(href);
    if (href == pathname) {
      $(this).css({'color': '#2e91b4 !important'})
    }
  })
}

function activeMondayViewMember() {
  $('.workloads-body-team').find('#workload_mon').removeClass('hide');
}

$('a[data-toggle="modal"]').click(function() {
  if ($('.modal-backdrop.in').length > 1) {

    $('.modal-backdrop').not(':first').remove();
  }
});

$(window).on('shown.bs.modal', function() {
  // console.log("click nè -- "+ $('.modal-backdrop.in').length);
  if ($('.modal-backdrop.in').length > 1) {
    $('.modal-backdrop').not(':first').remove();
  }
});

// $(document).on('turbolinks:load', function() {
//   activeMondayViewMember();
//   toggleMenuTeam();
//   displayIconMenuTeam();
//   activeTabDueSoon();
//   activeItemMenubottom();
//   toggleAdvSettingCreateTodo();
//   setWidthTodoName();
//   setColorTodoName();
//   addClassActiveMenu();
//
//   // set content right
//   set_height_scroll('right-container', '.right-header', '', '', '', '.wrapper-todo-team-list', 0);
//   set_height_scroll('.speed-duesoon', '.right-header', '.speed-panel-wrapper', '', '', '.wrapper-todo-team-list', 0);
//   set_height_scroll('right-container', '.right-header', '.speed-panel-heading', '.speed-todo-list-name', '.col.md-12.speed-wordflow', '.wrapper-workflow-step', 200);
//   set_height_scroll_by_screen('.speed-duesoon', '.speed-header', '.workloads-head', '.pane-hscroll-show', '', '.wrapper-todo-team-list', 250);
//   set_height_scroll('.workloads-main', '.workloads-head', '.speed-search-box', '', '.speed-btn', '.wrapper-todo-team-list', 20);
//
//   $(function() {
//     $("#sortable").sortable();
//     $("#sortable").disableSelection();
//   });
//
// });

$(document).ready(function() {
  //init
  removeEmptyTeamPage();
  removeEmptyWorkloadPage();
  removeEmptyChecklistPage();
  activeTabDueSoon();
  activeItemMenubottom();
  setWidthTodoName();
  setColorTodoName();
  activeMondayViewMember();
	viewWorkloadMember();
  // commentFunction();
  toggleTodoOption();
  privateTodo();
  changeTypeTodo();
  toggleAdvSettingCreateTodo();
  toggleTodoTotal();
  toggleMenuTeam();
  displayIconMenuTeam();
  addClassActiveMenu()

  //goi lai cac ham nay khi close modal
  $('body').on('hidden.bs.modal', '.modal', function() {
    $(".modal-content").html("");
    toggleTodoOption();
    privateTodo();
    changeTypeTodo();
    toggleAdvSettingCreateTodo();
    toggleTodoTotal();
    toggleMenuTeam();
    $('.choz').chosen();
    displayIconMenuTeam();
    addClassActiveMenu();
    activeItemMenubottom();
    setWidthTodoName();

  });
  $('body').on('hidden.bs.modal', '#createTodoModal.modal', function() {
    $(".modal-content").html("");
  });
  $('body').on('hidden.bs.modal', '#foxyModal.modal', function() {
    $(".modal-content").html("");
  });
  $('body').on('hidden.bs.modal', '#viewWorkloadModal.modal', function() {
    $(".modal-content").html("");
  });

  //khi modal open se goi cac ham nay;
  $('body').on('show.bs.modal', '.modal', function() {
    changeTypeTodo();
    privateTodo();
    viewWorkloadMember();
    activeMondayViewMember();

  });

  //waiting when call ajax
  var $body = $("body");
  $(document).on({
    ajaxStart: function() {
      $body.addClass("loading");
      console.log('calling ajax;');
      if ($('.modal-backdrop.in').length > 1) {
        $('.modal-backdrop').not(':first').remove();
      }
    },
    ajaxStop: function() {
      $body.removeClass("loading");
      console.log('ajax done')
    }
  });

  //delete todo list
  $(".delete-todo-list").on('click', function() {
    if (confirm("Do you want to delete?") == true) {
      $.ajax({
        url: '/todo_lists/' + $(this).attr("data"),
        type: 'PUT',
        data: {
          "completed": $(this).attr("data"),
          "name": "delete"
        }
      }).success(function() {
        alert('Deleted Todo List')
        location.reload();
        // $(this).parent().parent().parent().parent().remove()
      });
    }
  });

  //delete team
  $(".btn.btn-sign-up-now-without-bg.btn-xs.glyphicon.glyphicon-remove").on('click', function() {
    if (confirm("Do you want to delete?") == true) {
      $.ajax({
        url: '/teams/' + $(this).attr("data"),
        type: 'PUT',
        data: {
          "completed": $(this).attr("data"),
          "name": "delete"
        }
      }).success(function() {
        location.reload();
      });
    }
  });

  //re open todo list
  $(".re-open-todo").on('click', function() {
    if (confirm("Do you want to re-open todo-list?") == true) {
      $.ajax({
        url: '/todo_lists/' + $(this).attr("data"),
        type: 'PUT',
        data: {
          "completed": $(this).attr("data"),
          "name": "re-open-todo-list"
        }
      }).success(function() {
        location.reload();
        // $(this).parent().parent().parent().parent().remove()
      });
    }
  });

  //init datetimepicker
  $(function() {
    $('#datetimepicker3').datetimepicker({defaultDate: new Date(), format: 'YYYY-MM-DD'});

    $('#datetimepicker1').datetimepicker({defaultDate: new Date(), format: 'YYYY-MM-DD'});

    //on chang date in view member
    // $('#datetimepicker-member').datetimepicker(
    //  {
    //    format: 'YYYY-MM-DD'
    //  }).on('dp.change', function (e) {
    //    date = $(this).val()
    //    url = window.location.pathname
    //    path = url.split("?date=")[0];
    //    console.log(url.split("?date=")[1]);
    //    id_user = $('#user_id').val();
    //   window.location = url + "?date=" + date + "&user=" + id_user
    //  });

    //workload index change time
    $('#datepicker-workload').datetimepicker({format: 'YYYY-MM-DD'}).on('dp.change', function(e) {
      date = $(this).val()
      url = window.location.pathname
      window.location = url + "?date=" + date
    });

    $('#datetimepicker2').datetimepicker({format: 'YYYY-MM-DD'}).on('dp.change', function(e) {
      $.ajax({
        url: '/workloads/view_team',
        type: 'GET',
        data: {
          "team": $(".list-workflow").val(),
          "date": $('.date-week').val()
        }
      })
    });

    // $('#datetimepicker2').datetimepicker({
    //   defaultDate: new Date(),
    //   format: 'YYYY-MM-DD'
    // });
  });
  // console.log("fuck");

  //open modal
  $('#btn-createTodo').click(function() {
    $('#createTodo').modal();

  });

  // $('#adv-setting').on('click', function(e) {
  //   console.log('adv-setting onclick');
  //   e.preventDefault();
  //   $('#createTodo').toggleClass('hide');
  //   $('.todo-type-hide').toggleClass('hide-op');
  // })

  // Example 1
  $('.pane-hScroll').scroll(function() {
    $('.pane-vScroll').width($('.pane-hScroll').width() + $('.pane-hScroll').scrollLeft());
  });

  // add question
  let idQuestion = 0;
  $('#add-question').on('click', function addQuestion() {
    if ($('#stt-question').val())
      idQuestion = parseInt($('#stt-question').val()) + 1
    else
      idQuestion += 1;

    // console.log(idQuestion);
    var html_question = "<div class='question-wrapper'><span><span class='step-question' id='num num" + idQuestion + "'>" + idQuestion + ". </span></span><input class='speed-input speed-question' name='question" + idQuestion + "' placeholder='What is your question?' type='text'><span class='glyphicon glyphicon-remove remove-question'></span></div>"
    $('#stt-question').val(idQuestion);
    $('.question').append(html_question);
    $('.question').find('.question-wrapper:last-child').find('.glyphicon.glyphicon-remove.remove-question').on('click', function() {
      $(this).parent().remove();
      idQuestion -= 1;

    });

    // reset number label
    $('.remove-question').on('click', function() {
      // alert("modal content load");
      var n_question = 0;
      $('.step-question').each(function(index) {
        number = $(this).text();
        n_question++;
        if (number === n_question) {
          // console.log('yes');
        } else {
          // console.log('nos');
          $(this).text(n_question);
        }
      });
    });
    $('.require').on('focus', function() {
      $(this).parent().find('.error-alert').remove();
    });
  });
  $('.glyphicon.glyphicon-remove.remove-question').on('click', function() {
    $('#stt-question').val(parseInt($('#stt-question').val()) - 1)
    $(this).parent().remove();
  });

  //add Workflows
  var idWorkflow = 0;
  var $wrapper_new_workflow = $('.wrapper-new-workflow');
  $('#add-more-step').on('click', function(e) {
    if ($('.workflow-step').length > 0) {
      idWorkflow = parseInt($('.step-lable').last().text());
    }
    idWorkflow += 1;
    var html_workflow = '<div class="new-workflow-step"><div class="col-md-2 step-lable">' + idWorkflow + '</div><div class="col-md-10 input-step"><div><input class="speed-input input-step-workflow require" name="step' + idWorkflow + '" placeholder="Enter step name "></div><div class="relative"><div><p class="set-dealine input-group form-group speed-date-input><span class="input-group-addon"><span class="glyphicon glyphicon-time set-dealine"></span></span><input class="speed-input input-wf require" name="date' + idWorkflow + '" placeholder="Add estimate time" type="text"></p></div><input name="parent_id' + idWorkflow + '" class="previous-steps" placeholder = "Previous steps"></input></div></div><div class="icon-delete" id="delete-workflow-step"><span class="glyphicon glyphicon-remove"></span></div></div>';
    $wrapper_new_workflow.append(html_workflow);
    $wrapper_new_workflow.find('');
    $("#stt-workflows").val(idWorkflow);

    $('.icon-delete').on('click', function(e) {
      // console.log("icon delete click");
      $(this).parent().remove();
      idWorkflow -= 1;
    });

    $('.icon-delete').on('click', function(e) {
      // alert("modal content load");
      var n = 0;
      $('.step-lable').each(function(index) {
        number = $(this).text();
        n++;
        if (number === n) {
          // console.log('yes');
        } else {
          // console.log('nos');
          $(this).text(n);
          idWorkflow = parseInt($('.step-lable').last().text());
        }
      });
    });

    $('.require').on('focus', function() {
      $(this).parent().find('.error-alert').remove();
    });
  });

  $('#createWorkflow').on('click', function() {
    idWorkflow = 1;
    var html_workflow = '<div class="new-workflow-step">' + '<div class="col-md-2 step-lable">' + idWorkflow + '</div>' + '<div class="col-md-10 input-step">' + '<input class="speed-input input-step-workflow" name="step' + idWorkflow + '[name]" placeholder="Step ">' + '<p class="set-dealine input-group form-group speed-date-input">' + '<span class="input-group-addon"><span class="glyphicon glyphicon-time set-dealine"></span>' +
    //'</span>'+
    '<input name="step' + idWorkflow + '[date]" placeholder="Click here to add estimate time" type="text">' + '</p>' + '</div>' + '<div class="icon-delete" id="delete-workflow-step">' + '<span class="glyphicon glyphicon-remove"></span>' + '</div>' + '</div>';
    $wrapper_new_workflow.append(html_workflow);
    $('.require').on('focus', function() {
      $(this).parent().find('.error-alert').remove();
    });
  });

  //add check list step
  var idWorkflow = 0;
  var $wrapper_new_workflow = $('.wrapper-new-workflow');
  $('#add-more-step-check-list').on('click', function(e) {
    if ($('.workflow-step').length > 0) {
      idWorkflow = parseInt($('.step-lable').last().text());
    }
    idWorkflow += 1;
    var html_workflow = '<div class="new-workflow-step"><div class="col-md-2 step-lable">' + idWorkflow + '</div><div class="col-md-10 input-step"><div><input class="speed-input input-step-workflow require" name="step' + idWorkflow + '" placeholder="Enter step name "></div><div class="relative"><div><p class="set-dealine input-group form-group speed-date-input><span class="input-group-addon"> </span></p></div></div></div><div class="icon-delete" id="delete-workflow-step"><span class="glyphicon glyphicon-remove"></span></div></div>';
    $wrapper_new_workflow.append(html_workflow);
    $wrapper_new_workflow.find('');
    $("#stt-workflows").val(idWorkflow);

    $('.icon-delete').on('click', function(e) {
      // console.log("icon delete click");
      $(this).parent().remove();
      idWorkflow -= 1;
    });

    $('.icon-delete').on('click', function(e) {
      // alert("modal content load");
      var n = 0;
      $('.step-lable').each(function(index) {
        number = $(this).text();
        n++;
        if (number === n) {
          // console.log('yes');
        } else {
          // console.log('nos');
          $(this).text(n);
          idWorkflow = parseInt($('.step-lable').last().text());
          // console.log(idWorkflow);
        }
      });
    });

    $('.require').on('focus', function() {
      $(this).parent().find('.error-alert').remove();
    });
  });

  $('#createChecklist').on('click', function() {
    idWorkflow = 1;
    var html_workflow = '<div class="new-workflow-step"><div class="col-md-2 step-lable">' + idWorkflow + '</div><div class="col-md-10 input-step"> <input class="speed-input input-step-workflow" name="step' + idWorkflow + '[name]" placeholder="Step "><p class="set-dealine input-group form-group speed-date-input"><span class="input-group-addon"><span class="glyphicon glyphicon-time set-dealine"></span></span><input name="step' + idWorkflow + '[date]" placeholder="Click here to add estimate time" type="text"></p></div><div class="icon-delete" id="delete-workflow-step"><span class="glyphicon glyphicon-remove"></span></div></div>';
    $wrapper_new_workflow.append(html_workflow);
    $('.require').on('focus', function() {
      $(this).parent().find('.error-alert').remove();
    });
  });

  $('.speed-team-workload').find('table td').on('click', function() {
    $('.speed-team-workload').find('table td.active').removeClass('active');
    $(this).addClass('active');
  })
  var $height_wrapper = $('right-container').height();
  $('right-container').find('.speed-tabs-content').height($height_wrapper - 130);
});

// });
//click get value role of member
$('.team-managerment').find('span.cr').click(function() {
  if (($('#user_super_role').val()) == "2")
    $('#user_super_role').val("3");
  else if (($('#user_super_role').val()) == "3")
    $('#user_super_role').val("2")
  else if (($('#user_super_role').val()) == "1")
    $('#user_super_role').val("0")
  else
    $('#user_super_role').val("1")
});

$('.member-managerment').find('span.cr').click(function() {
  if (($('#user_super_role').val()) == "1")
    $('#user_super_role').val("3")
  else if (($('#user_super_role').val()) == "3")
    $('#user_super_role').val("1")
  else if (($('#user_super_role').val()) == "2")
    $('#user_super_role').val("0")
  else
    $('#user_super_role').val("2");

  $('.cr-icon.glyphicon.glyphicon-ok').on('click', function() {
    $(this).parent().css({'border': '0px'})
  });
});
//document on ready

$(document).ajaxComplete(function(event, request, settings) {
  // set width for td tag on workload page
  var wrapper_workload = $('.setwidth-table');
  var width_th = wrapper_workload.find('tr th').outerWidth();
  // console.log("width tr : "+width_th);
  wrapper_workload.find('tr.result td').css('width', width_th);
  $('.scrollbar-rail').scrollbar();

  $(function() {
    $.contextMenu({
      selector: '.context-menu-one',
      callback: function(key, options) {
        // var m = "clicked: " + key;
        // window.console && console.log(m) || alert(m);
      },
      items: {
        "edit": {
          name: "Edit",
          icon: "edit"
        },
        // "delete": {name: "Delete", icon: "delete"},
        "sep1": "---------",
        "quit": {
          name: "Quit",
          icon: function() {
            return 'context-menu-icon context-menu-icon-quit';
          }
        }
      }
    });

    $('.context-menu-one').contextmenu(function() {
      var context_id = $(this).parent().parent().attr('id');
      if ($(".context-menu-list").find('a').length < 1) {
        $(".context-menu-list").find('.context-menu-icon-edit span').wrap(function() {
          // return "<a href=/todos/"+ context_id +"/edit></a>";
          return '<a data-keyboard="false" data-backdrop="static" data-toggle="modal" data-target="#foxyModal" href="/todos/' + context_id + '/edit"></a>';
        });
        $(".context-menu-list").find('.context-menu-icon-delete span').wrap(function() {
          return "<a href='/todos/" + context_id + "'></a>";
        });
      }

      // console.log(context_id);
      // $('.context-menu-list').
    });

    $('.context-menu-one').on('click', function(e) {
      // console.log('clicked', this);
    });
  })
});

// *****START SET SCROLL FORM
// 1. add class before ".form-todo-list": .wrapper-todo-team-list-css
// 2. Add class into simple_form: .event-add-division
// 3. import file script into haml file: = javascript_include_tag 'set_scroll_form_crud'
// import:
// 1. Todolist: crud form
// 2. Todo: crud form

function set_height_scroll_only(wrapper, el1, el2, el3, el4, el_set_heigth, outWidth) {
  var wrapper_el = $(wrapper);
  var h_wrapper = wrapper_el.height();
  var h_el1 = wrapper_el.find(el1).outerHeight(true);
  var h_el2 = wrapper_el.find(el2).outerHeight(true);
  var h_el3 = wrapper_el.find(el3).outerHeight(true);
  var h_el4 = wrapper_el.find(el4).outerHeight(true);

  var set_height_element = h_wrapper - h_el1 - h_el2 - h_el3 - h_el4 - 40 - outWidth;
  wrapper_el.find(el_set_heigth).css('height', set_height_element + 'px');
}

$(document).ajaxComplete(function() {
  set_height_scroll_only('.form-module .form', '.padding-left-20px', '', '', '', '.wrapper-todo-team-list-css', 50);
  if ($('.form-todo-list').height() > $('.wrapper-todo-team-list-css').height() && $('.division').length < 1) {
    $('.form-group').append("<div class='division'></div>");
  } else {
    $('.form-group').remove("div.division");
  }
  $(".add-question, .remove-question, input[type='radio'], #adv-setting").click(function(e) {
    if ($('.form-todo-list').height() > $('.wrapper-todo-team-list-css').height() && $('.division').length < 1) {
      $('.event-add-division').append("<div class='division'></div>");
    } else {
      $('.event-add-division').remove("div.division");
    }
  });
});
// *****END SET SCROLL FORM

function set_height_scroll(wrapper, el1, el2, el3, el4, el_set_heigth, outWidth) {
  // wrapper -> el wrapper khu vực cần xử lý height
  // el1, el2, el3 -> các el cần trừ height
  // el_set_height -> el cần add height được xử lý
  var wrapper_el = $(wrapper);
  var h_wrapper = wrapper_el.height();
  var h_el1 = wrapper_el.find(el1).outerHeight(true);
  var h_el2 = wrapper_el.find(el2).outerHeight(true);
  var h_el3 = wrapper_el.find(el3).outerHeight(true);
  var h_el4 = wrapper_el.find(el4).outerHeight(true);

  var set_height_element = h_wrapper - h_el1 - h_el2 - h_el3 - h_el4 - 40 - outWidth;
  // console.log("setheight: " + set_height_element);
  // console.log(outWidth);
  wrapper_el.find(el_set_heigth).addClass('scrollbar-rail');
  $('.scrollbar-rail').scrollbar();
  wrapper_el.find(el_set_heigth).css('height', set_height_element + 'px');
}

function set_height_scroll_by_screen(wrapper, el1, el2, el3, el4, el_set_heigth, outWidth) {
  var wrapper_el = $(wrapper);
  var h_wrapper = wrapper_el.height();
  var h_el1 = wrapper_el.find(el1).outerHeight(true);
  var h_el2 = wrapper_el.find(el2).outerHeight(true);
  var h_el3 = wrapper_el.find(el3).outerHeight(true);
  var h_el4 = wrapper_el.find(el4).outerHeight(true);

  var set_height_element = $(window).height() - h_el1 - h_el2 - h_el3 - h_el4 - 40 - outWidth;
  // console.log(set_height_element);
  wrapper_el.find(el_set_heigth).addClass('scrollbar-rail');
  $('.scrollbar-rail').scrollbar();
  wrapper_el.find(el_set_heigth).css('height', set_height_element + 'px');
}

function limitTextLeft() {
  var wrapperWidth = $('left-container').find('.team-name.speed-panel').width() - 100;
  // console.log(wrapperWidth);
  $('left-container').find('.today-task-items').each(function() {
    var todo_width = $(this).find('.todo-name.one-line-text').width()
    // console.log(todo_width);

    if (todo_width >= wrapperWidth) {
      $(this).find('.todo-name.one-line-text').css({'width': 'auto', 'max-width': '220px'});
      $(this).find('.task-member.team').hide();
    }
  });
}

function limitTextWorkload() {

  var $wrapper = $('.workloads-body-detail');

  var wrapperWidth = $wrapper.outerWidth(true)
  // console.log(wrapperWidth);

  $('.wrapper-workload').each(function() {
    $(this).find('.wrapper-workload-member').find('.task-item').each(function() {
      todo_width = $(this).find('.checkbox').find('.todo-name.one-line-text').width();
      console.log('todo_width: ' + todo_width);
      if (todo_width >= wrapperWidth) {
        $(this).find('.todo-name.one-line-text').css({'max-width': '600px'});
        $(this).find('.task-member.team').hide();
      }
    });
  });
}
$(window).on('load', function() {
  //back
  $('.glyphicon-chevron-left').on('click', function() {
    window.history.back()
  })
  // on chang team in workflows
  $('#list-workflow').on('change', function() {
    var id = $(this).val();
    var team_id = $(this).parent().find('input').val()
    var url = "/teams/" + team_id + "/workflows/" + id
    window.location = url
  });

  limitTextWorkload();
  setWidthTodoName();
  limitTextLeft();
  $('.tab-link').on('click', function() {
    setWidthTodoName();
  });

  $(".select-select2").select2();

  $('.workloads-head').click(function() {
    console.log("click");
    set_height_scroll('.select2-results', '', '', '', '', '#select2-list-workflow-results', 0);
  });
});

$(document).ready(function($) {
  $('#member-table').tablesort();
  $('#workload-member').tablesort();

  //metting on todo on lick
  $('.metting').find('span.cr').click(function() {
    if ($('.category').val() == "1") {
      $('.category').val("2");
      console.log("asd" + $('.category').val());
      $('form').find('.deadline-title').text('Date');
      $('form').find('#location').append('<div class="input string optional todo_location"><label class="string optional" for="todo_location">Location</label><input class="string optional speed-input require" placeholder="Enter your todo name" type="text" name="todo[location]" id="todo_location"></div>');
      $('.require').on('focus', function() {
        $(this).parent().find('.error-alert').remove();
      })
    } else {
      $('.category').val("1");
      console.log("xzc" + $('.category').val());
      $('form').find('.deadline-title').text('Deadline');
      $('form').find('#location').empty();
    }
  })
  $('.wrapper-todo-team-list .today-task-items').each(function() {
    $(this).find('a.todo-name').attr('data-search-term', $(this).find('.checkbox .todo-name').text().toLowerCase());
  });

  $('#search-todolist').on('keyup', function() {
    var searchTerm = $(this).val().toLowerCase();
    // console.log(searchTerm);
    $('.wrapper-todo-team-list .today-task-items').each(function() {
      if ($(this).find('.checkbox .todo-name').filter('[data-search-term *= ' + searchTerm + ']').length > 0 || searchTerm.length < 1) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
  });

  $("#search-member").keyup(function() {
    var value = this.value.toLowerCase();
    liveSearch('#member-table', value)
  });
  $("#search-member").keyup(function() {
    var value = this.value.toLowerCase();
    liveSearch('#workload-member', value)
  });

  function liveSearch(searchSelector, value) {
    console.log(value);
    $(searchSelector).find("tr").each(function(index) {
      if (index === 0)
        return;
      var id = $(this).find("td").first().text().toLowerCase();
      $(this).toggle(id.indexOf(value) !== -1);
    });
  }

});
$(".select.optional.user-role.speed-input").on('change', function() {
  $.ajax({
    type: "GET",
    url: "/todo_lists",
    dataType: "json",
    data: {
      workflow: $(this).val()
    },
    success: function(result) {
      console.log(result[0]["step"]);
      console.log(result[0]["users"]);
      $('.workflow-step').remove();
      id = 5
      $.each(result[0]["step"], function(k, v) {
        id++;

        string = '<div class="row workflow-step">' + '<div class="col-md-12 step-name">' + v.name + '</div>' + '<div class="row">' + '<div class="col-md-5">' + '<input id="datetimepicker' + id + '" class="speed-input remove-margin remove-padding date-week require" name="deadline-' + v.id + '" placeholder="Add deadline" type="text">' + '</div>' + '<div class="col-md-7 step-assign-to">' + '<span class="col-md-4 title remove-margin remove-padding"> Assign to: </span>' + '<select class="col-md-8 speed-input remove-margin remove-padding select2 member-team" name="name_step_' + v.id + '"></select2>' + '</div>' + '</div>' + '</div>'
        $('.step-workflow-create-todo').append(string);

        id_name = '#datetimepicker' + id;

        $(id_name).datetimepicker({defaultDate: new Date(), format: 'YYYY-MM-DD'});
      })
      $.each(result[0]["users"], function(k, v) {
        string = '<option value="' + v.id + '">' + v.name + '</option>'
        $('.member-team').append(string);
        $('.require').on('focus', function() {
          $(this).parent().find('.error-alert').remove();
        });
      })
    }
  });
});

//call workflow viem step member
$(window).on('load', function() {

  var url = window.location.href
  var date = url.split("&date=")[1];
  $('.form-inline').find('#datetimepicker1').find('input').val(date)

  $("select#member-teams").on('change', function() {
    url = window.location.href
    path = url.split("workloads")[1];
    console.log("/teams/" + $(this).val() + path);
    window.location = "/teams/" + $(this).val() + '/workloads' + path;
  })

  url = window.location.pathname
  var regexp = /workflows\/\d/gi;

  if (url.match(regexp))
    $.ajax({
      type: "GET",
      url: url,
      dataType: "json",
      data: {
        name: "get-view"
      },
      success: function(result) {

        $.each(result, function(k, v) {

          if (v.finish == "last") {}
          if (v.position != "") {
            if (v.finish == "last") {
              find = '[data="' + v.id_todo + '"]';
              string = '<div><i class="fa fa-dot-circle-o"></i><p>' + v.name + '</p><p class="date">' + v.due_date + '</p></div>'
              $(find).append(string).find('div').attr('id', v.id);
            } else {
              find = '[name=' + v.position + ']';
              string = '<a data-keyboard="false" data-backdrop="static" data-toggle="modal" data-target="#foxyModal" href="/todos/' + $(find).attr('id') + '"><div><i class="fa fa-dot-circle-o"></i><p>' + v.name + '</p><p class="date">' + v.due_date + '</p></div></a>'
              $(find).append(string).find('div').attr('id', v.id).addClass('context-menu-one');
            }
            $.ajax({
              type: "GET",
              url: url,
              dataType: "json",
              data: {
                name: "get_id"
              },
              success: function(result) {
                $.each(result, function(k, v) {
                  var id = v.id;
                  var id_step = '#name-' + id;
                  console.log("id: " + id_step);
                  var selector_id_step = $(id_step);
                  var selector_droppable = $('table').find('[droppable_todo = name-' + v.id + ']');

                  selector_id_step.draggable({
                    revert: 'invalid',
                    helper: 'clone',
                    grid: [20, 20]

                  });
                  selector_droppable.droppable({
                    accept: String(id_step),
                    drop: function(event, ui) {
                      // $(ui.draggable).detach().appendTo($(this));
                      member = $(ui.draggable).detach().appendTo($(this)).parent();
                      // ajax done workflow
                      if (member.attr('name') == "finish") {
                        $.ajax({
                          type: "GET",
                          url: "/todos/" + member.attr('data') + "/check_done",
                          dataType: "json",
                          data: {
                            name: "done_workflow",
                            flag: "last",
                            todo_list: member.parent().attr('name')
                          },
                          success: function(result) {
                            location.reload();
                          }
                        });
                      } else {
                        $.ajax({
                          type: "GET",
                          url: "/todos/" + member.attr('id') + "/check_done",
                          dataType: "json",
                          data: {
                            name: "done_workflow",
                            todo_list: member.parent().attr('name')
                          },
                          success: function(result) {
                            location.reload();
                          }
                        });
                      }

                    }
                  });
                })
              }
            });
          }
        })
      }
    });
  }
)

// handle error client
$(document).on('ready', function() {

  // check list

  $('.checkbox.check_list').find('input').on('click', function() {
    var string = "{";
    $('.checkbox.check_list').find('input').each(function() {
      if (string == "{")
        string = string + '"' + $(this).attr('name') + '":"' + (
        $(this).is(":checked")) + '"';
      else
        string = string + ',"' + $(this).attr('name') + '":"' + (
        $(this).is(":checked")) + '"';
      }
    );
    string = string + '}';
    // console.log(string);
    //save check list
    $.ajax({
      url: '/todos/' + $('#todo_id').val(),
      type: 'PUT',
      data: {
        name: "check_list",
        list: string
      }
    })
  })

  $('.submit-btn').on('click', function() {
    var ok = "";
    var frm = $(this).parent().parent().find('.simple_form');

    frm.find('.require').each(function() {
      var requireField = $(this).parent().text();
      var value = $(this).val();
      if (!value) {
        ok += requireField + "\n is require";
        $(this).parent().append("<div class='error-alert'>This field is require</div>")
      }
    })

    if (ok == "") {
      frm.submit();
    } else {
      // alert("Please enter missing infomations");
    }
  })
  $('.require').on('focus', function() {
    $(this).parent().find('.error-alert').remove();
  });

  $('.date-week-edit').datetimepicker({defaultDate: new Date(), format: 'YYYY-MM-DD'});

  $("#more-activities").on('click', function() {
    var url = window.location.pathname;
    var selectorAppend = $('table.table.table-fixed#activity-table').find('tbody')
    offset = selectorAppend.find('tr').length;
    // offset = $('.row.wrapper').find('p').length;
    $.ajax({
      url: url,
      type: 'GET',
      data: {
        name: "more",
        offset: offset
      }
    }).success(function(result) {
      $.each(JSON.parse(result), function(k, v) {
        string = '<tr class="user-info">' + '<td class="col-xs-3 col-md-3">' + '<span class="user-name">' + v.fullname + '</span>' + '</td>' + '<td class="col-xs-6 col-md-6">' + '<span class="user-title">' + v.event + '&nbsp' + v.category + '<strong> ' + v.name + '</strong>' + '</span>' + '</td>' + '<td class="col-xs-3 col-md-3"> &nbsp' + '<span> ' + v.datetime + '</span>' + '</td>' + '</tr>';
        // string = '<p>'+ v.fullname +' '+ v.event + ' ' + v.category + 'on <strong> '+ v.name +' </strong> </p>';
        selectorAppend.append(string);
      });
      offset = selectorAppend.find('tr').length;

    });
  });

  //ajax upload file
  $('#datum_files').on('change', function() {

    setTimeout(function() {
      $('#new_datum').submit();
    }, 1000)
  })

  // $('.plus-files').on('click', function(){
  //   $('#datum_files').click()
  // });

  $('.delete-workflow').on('click', function() {
    if (confirm("Are you Delete?") == true) {
      var url = window.location.pathname;
      $.ajax({
        url: url,
        type: 'GET',
        data: {
          name: "delete",
          id_workflow: $(this).attr('data')
        }
      }).success(function(result) {
        location.reload();
      })
    }
  });
})

$(window).on('load', function() {
  $('.require').on('focus', function() {
    $(this).parent().find('.error-alert').remove();
  });
})

$(document).ready(function() {

  $('.wrapper-one-todo-list').find('.catagory-noti.limit-text').find('a').on('click', function(e) {
    $(this).parent().parent().parent().parent().css("background-color", "fff")

    $.ajax({
      url: '/notifications/' + $(this).parent().parent().parent().parent().attr('name'),
      type: 'PUT',
      data: {
        name: "view",
        view_user_id: $('#id_user').val()
      }
    }).success(function(result) {});
  })

  $('#btn_add_attach_file_comment').on('click', function(e) {
    $('#comment_files').trigger('click');

    $('#comment_files').change(function(e) {
      var filename = $('#comment_files').val();
      if (filename.substring(3, 11) == 'fakepath') {
        filename = filename.substring(12);
      }
      html = "<div title='" + filename + "'>Attach file: " + filename + "<span class='remove-attach-file'>remove<span></div>";
      $('.wrapper-attach-file-uploaded').html(html);
      // console.log(filename);
      // $('.wrapper-attach-file-uploaded').append("<div title='"+filename+"'>" + filename + "</div>");
      $('.remove-attach-file').click(function() {
        console.log("remove click");
        $(this).parent().remove();
      });
    });
  });

  // set width limit text in notification page
  $('.today-task-items').each(function() {
    var set_with_todo = $(this).find('.task-item').width() - $(this).find('.user-name-noti').outerWidth() - $(this).find('.event-noti').outerWidth() - $(this).find('.timestamp-noti').outerWidth() - 35;
    // console.log(set_with_todo);
    if (set_with_todo > 0) {
      $(this).find('.catagory-noti').width(set_with_todo);
    }
  });
});

$(document).on('load', function() {
  //toggle class hide add todo-list

  $('#notificationList').find('li').on('click', function() {
    $.ajax({
      url: '/notifications/' + $(this).attr('name'),
      type: 'PUT',
      data: {
        name: "view",
        view_user_id: $('#id_user').val()
      }
    })
  })
})

$(window).on('load', function() {
  console.log('load');
  var selectorScroll = $('.todo-list-panel.wrapper-todo-team-list.remove-padding-left.scrollbar-rail.scroll-content.scroll-scrollx_visible.scroll-scrolly_visible');
  selectorScroll.on('scroll', function(e) {
    // grab the scroll amount and the window height
    var scrollAmount = $(this).scrollTop();
    var heigth_ = $(this).height();
    var scrollHeight = $(this).prop('scrollHeight');
    console.log($('.wrapper-one-todo-list').length);
    // console.log($('#idnotifi').find('.scroll-element_outer').find('.scroll-bar').height());
    // console.log(scrollAmount);
    // console.log('height: ' + heigth_);
    // console.log($('.scroll-bar').height());
    // calculate the percentage the user has scrolled down the page
    var scrollPercent = (scrollAmount / heigth_) * 100;
    // console.log('phan tram: ' + scrollPercent);

    if (scrollAmount + heigth_ >= scrollHeight) {
      if ($('.wrapper-one-todo-list').length < parseInt($('#idnotifi').attr('name')) && $('#idnotifi').attr('name') >= 1) {

        AjaxNotificationView()
      }
    }

    function AjaxNotificationView() {
      offset = $('.wrapper-one-todo-list').length + 1
      //re open todo list
      var url = window.location.pathname;
      $.ajax({
        url: url,
        type: 'GET',
        data: {
          name: "more",
          offset: offset
        }
      }).success(function(result) {
        if (JSON.parse(result).length < 10)
          $('#idnotifi').attr('name', 0)
        $.each(JSON.parse(result), function(k, v) {
          if ($.inArray($('#id_user').val(), v.user_list) == -1)
            if (v.category == "todo list")
              string = '<div class="wrapper-one-todo-list" style="background-color: #F5F5F5">' + '<div class="todo-list-name">' + v.parent_id + '</div>' + '<div class="row today-task-items"><div class="col-md-12 task-item">' + '<div class="user-name-noti">' + v.user + '</div><div class="event-noti">&nbsp' + v.event + ' on </div>' + '<div class="catagory-noti limit-text" >' + '<a data-backdrop="static" data-toggle="modal" href="' + v.url + '">&nbsp' + v.name + '</a></div>' + '<div class="timestamp-noti"> at ' + v.date + '</div> </div> </div> </div>';
            else
              string = '<div class="wrapper-one-todo-list" name="' + v.id + '"  style="background-color: #F5F5F5">' + '<div class="todo-list-name">' + v.parent_id + '</div>' + '<div class="row today-task-items"><div class="col-md-12 task-item">' + '<div class="user-name-noti">' + v.user + '</div><div class="event-noti">&nbsp' + v.event + ' on </div>' + '<div class="catagory-noti limit-text" >' + '<a data-backdrop="static" data-target="#foxyModal" data-toggle="modal" href="' + v.url + '">&nbsp' + v.name + '</a></div>' + '<div class="timestamp-noti"> at ' + v.date + '</div> </div> </div> </div>';

else if (v.category == "todo list")
              string = '<div class="wrapper-one-todo-list" style="background-color: fff">' + '<div class="todo-list-name">' + v.parent_id + '</div>' + '<div class="row today-task-items"><div class="col-md-12 task-item">' + '<div class="user-name-noti">' + v.user + '</div><div class="event-noti">&nbsp' + v.event + ' on </div>' + '<div class="catagory-noti limit-text" >' + '<a data-backdrop="static" data-toggle="modal" href="' + v.url + '">&nbsp' + v.name + '</a></div>' + '<div class="timestamp-noti"> at ' + v.date + '</div> </div> </div> </div>';
            else
              string = '<div class="wrapper-one-todo-list" name="' + v.id + '" style="background-color: fff">' + '<div class="todo-list-name">' + v.parent_id + '</div>' + '<div class="row today-task-items"><div class="col-md-12 task-item">' + '<div class="user-name-noti">' + v.user + '</div><div class="event-noti">&nbsp' + v.event + ' on </div>' + '<div class="catagory-noti limit-text" >' + '<a data-backdrop="static" data-target="#foxyModal" data-toggle="modal" href="' + v.url + '">&nbsp' + v.name + '</a></div>' + '<div class="timestamp-noti"> at ' + v.date + '</div> </div> </div> </div>';

          $('.speed-tabs-content.current').append(string);
        });
        offset = $('.wrapper-one-todo-list').length + 1
      });
    }
  })
})

function viewWorkloadMember() {
  var items = $('.workloads-body-team').find('table');
  items.find("tr td").each(function(index) {

    $(this).click(function() {
      console.log('thiet la te')

      items.find('tr td').removeClass('active');
      $(this).addClass('active');

      $(this).parents('.workloads-body-team').find('.workloadTotal').addClass('hide')
      var href_value = $(this).find('a').attr('href');
      console.log('href_value: ' + href_value);
      switch (href_value) {
        case '#mon':
          $(this).parents('.workloads-body-team').find('#workload_mon').removeClass('hide');
          console.log(1)
          break;
        case '#tues':
          $(this).parents('.workloads-body-team').find('#workload_tue').removeClass('hide');
          console.log(2)
          break;
        case '#wed':
          $(this).parents('.workloads-body-team').find('#workload_web').removeClass('hide');
          console.log(3)
          break;
        case '#thurs':
          $(this).parents('.workloads-body-team').find('#workload_thu').removeClass('hide');
          console.log(4)
          break;
        case '#fri':
          $(this).parents('.workloads-body-team').find('#workload_fri').removeClass('hide');
          console.log(5)
          break;
        case '#sat':
          $(this).parents('.workloads-body-team').find('#workload_sat').removeClass('hide');
          console.log(6)
          break;
        case '#sun':
          $(this).parents('.workloads-body-team').find('#workload_sun').removeClass('hide');
          console.log(7)
          break;
        default:
          console.log(0)
      }
    });
  });
}
