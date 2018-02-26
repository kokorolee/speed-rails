function privateTodo(){
  $('#private').find('span.cr').click(function(){
    if ($('.private').val()=="1")
      $('.private').val("2");
    else
        $('.private').val("1");
    console.log($('.private').val());
  })
}

function changeTypeTodo(){
  console.log('changeTypeTodo');
  $('.workload-radio').on('click', function() {
    console.log('workload.click');
    $('#todo_list_category').val("2");
    $('.todo_list_parent_id').find('label').hide()
    $('.wrapper-workflow').removeClass('hide');
    $('.wrapper-question').addClass('hide');


  });
  $('.question-radio').on('click', function() {
    $('#todo_list_category').val("3")

    $('.wrapper-question').removeClass('hide');
    $('.wrapper-workflow').addClass('hide');
    $('.step-workflow-create-todo').html("");

  });
  $('.project-radio').on('click', function() {
    $('#todo_list_category').val("1");

    $('.wrapper-question').addClass('hide');
    $('.wrapper-workflow').addClass('hide');
    $('.step-workflow-create-todo').html("");
    
  });
}

function toggleTodoOption(){
  var flat_click = false;
  // $('right-container').find('.icon-menu-task').on('click', function(e){
  $('.icon-menu-task').on('click', function(e){
    // console.log("click icon menu task");
    if (!flat_click){
      //function
      var id = $(this).parent().find('input').val();
      var todo_list_id= $('#todo_list_id').val()
      if (todo_list_id==null)
        todo_list_id = $(this).parent().parent().find('.todo_list_id').val();
      $('.edit-todo').attr({

        href: "/todos/" + id + "/edit?todo_list_id=" + todo_list_id,
        "data-id": id
      });
      $('.delete-todo').attr({
        "data": id
      });

      $('.todo-option').show();

      var position = $(this).offset();
      $('#component-action').css({'z-index': 1, top: position.top, left: position.left-70});
      flat_click = true;
    }
    else {
      console.log("add class");

      //function
      $('.todo-option').hide();
      flat_click = false;
    }
    // e.stopPropagation();
  });
}
function toggleAdvSettingCreateTodo(){
  console.log('toggleAdvSettingCreateTodo')
  $('#adv-setting').on('click', function(e) {
    console.log('adv-setting onclick');
    e.preventDefault();
    $('#createTodo').toggleClass('hide');
    $('.todo-type-hide').toggleClass('hide-op');
  })
}

function toggleTodoTotal (){
  // $('li.today-task-items').find('.todo-list-name-left').toggle(function(e) {
  //   $(this).closest("li").find("[class^='ul_submenu']").slideToggle(0);
  // });
}

$(document).ready(function() {
  //kéo thar todo và task
  $('.sortable').sortable({
    stop: function() {
      var inputs = $('.ui-sortable-handle');
      var nbElems = inputs.length;

      $('.ui-sortable-handle').each(function(idx) {
        $(this).val(nbElems - idx);
        id = $(this).find('.checkbox').find('input').val();
        console.log("Value: ", id);
        console.log("idx", idx)
        //ajax update position
        $.ajax({
          url: '/todos/' + id,
          type: 'PUT',
          data: {
            "position": idx + 1,
            "name": "update_position"
          }
        });
      });
      if (window.location.pathname == "/backlogs")
        location.reload();
    }
  });


  //delete todo
  $(".delete-todo").on('click', function() {
    if (confirm("Do you want to delete?") == true) {
      $.ajax({
        url: '/todos/' + $(this).attr("data"),
        type: 'PUT',
        data: {
          "completed": $(this).attr("data"),
          "name": "delete"
        }
      }).success(function() {
        location.reload();
        // $(this).parent().parent().parent().parent().remove()
      });
    }
  });

  //event check done
  $("span.cr.todos").parent().find("input").on('click', function() {
    if (confirm("Are you sure?") == true) {
      $.ajax({
        url: '/todos/' + this.value,
        type: 'PUT',
        data: {
          "name": "check_done"
        }
      }).done(function() {
        location.reload();
      });
    } else {
      $("span.cr.todos").parent().find("input").attr('checked', false);
    }
  });

})
