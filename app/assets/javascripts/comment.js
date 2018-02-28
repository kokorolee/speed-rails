function AjaxComment(result) {
  $.each(result, function() {
    $.each(this, function(k, v) {
      if (v.importank != 1)
        if ($('.comment-content-wrapper').find('input').val() == v.user_id)
          if (v.files != null)
            string_result = '<div class="row comment-content-user"><div class="box-comment-user"><div class="wrapper-img"><img src="'+v.avatar+'"></div></div><div class="col-md-10 comment-content" name="'+v.id+'"><div class="comment-username">' + v.name +
            '</div><div class="comment-user-role">' + v.role + '</div><div class="comment-user-content">' + v.content + '</div><div class="form-hidden-comment"></div><div class="row"><div class="col-md-4 img attachment add-attachment"><div class="wrapper-upload"><div class="image-upload"><img src="'+v.files+'"></div></div></div></div><div class="comment-control"><a class="mark-important" href="#"><input type="hidden" value="' + v.id + '"><span class="mark-important">Mark this important</span></a><span class="glyphicon glyphicon-asterisk"></span><a href="#"><span class="edit edit-comment">Edit</span></a><span class="glyphicon glyphicon-asterisk"></span><span class="delete-comment"><a data-remote="true" rel="nofollow" data-method="delete" href="/comments/' + v.id + '">Delete</a></span></div></div></div>'
          else
            string_result = '<div class="row comment-content-user"><div class="box-comment-user"><div class="wrapper-img"><img src="'+v.avatar+'"></div></div><div class="col-md-10 comment-content" name="'+v.id+'"><div class="comment-username">' + v.name +
            '</div><div class="comment-user-role">' + v.role + '</div><div class="comment-user-content">' + v.content + '</div><div class="form-hidden-comment"></div><div class="row"></div><div class="comment-control"><a class="mark-important" href="#"><input type="hidden" value="' + v.id + '"><span class="mark-important">Mark this important</span></a><span class="glyphicon glyphicon-asterisk"></span><a href="#"><span class="edit edit-comment">Edit</span></a><span class="glyphicon glyphicon-asterisk"></span><span class="delete-comment"><a data-remote="true" rel="nofollow" data-method="delete" href="/comments/' + v.id + '">Delete</a></span></div></div></div>'
        else
          if (v.files != null)
            string_result = '<div class="row comment-content-user"><div class="box-comment-user"><div class="wrapper-img"><img src="'+v.avatar+'"></div></div><div class="col-md-10 comment-content" name="'+v.id+'"><div class="comment-username">' + v.name +
            '</div><div class="comment-user-role">' + v.role + '</div><div class="comment-user-content">' + v.content + '</div><div class="form-hidden-comment"></div><div class="row"><div class="col-md-4 img attachment add-attachment"><div class="wrapper-upload"><div class="image-upload"><img src="'+v.files+'"></div></div></div></div><div class="comment-control"><a class="mark-important" href="#"><input type="hidden" value="' + v.id + '"><span class="mark-important">Mark this important</span></a></span>'
          else
            string_result = '<div class="row comment-content-user"><div class="box-comment-user"><div class="wrapper-img"><img src="'+v.avatar+'"></div></div><div class="col-md-10 comment-content" name="'+v.id+'"><div class="comment-username">' + v.name +
            '</div><div class="comment-user-role">' + v.role + '</div><div class="comment-user-content">' + v.content + '</div><div class="form-hidden-comment"></div><input type="hidden" value="' + v.id + '"><span class="mark-important">Mark this important</span></a></span>'
      else if (v.importank == 1)
        if ($('.comment-content-wrapper').find('input').val() == v.user_id)
          if (v.files != null)
            string_result = '<div class="row comment-content-user"><div class="box-comment-user"><div class="wrapper-img"><img src="'+v.avatar+'"></div></div><div class="col-md-10 comment-content" name="'+v.id+'"><div class="comment-username">' + v.name +
            '</div><div class="comment-user-role">' + v.role + '</div><div class="comment-user-content">' + v.content + '</div><div class="form-hidden-comment"></div><div class="row"><div class="col-md-4 img attachment add-attachment"><div class="wrapper-upload"><div class="image-upload"><img src="'+v.files+'"></div></div></div></div><div class="comment-control"><a class="mark-important" href="#"><input type="hidden" value="' + v.id + '"><span class="mark-important">Important</span></a><span class="glyphicon glyphicon-asterisk"></span><a href="#"><span class="edit edit-comment">Edit</span></a><span class="glyphicon glyphicon-asterisk"></span><span class="delete-comment"><a data-remote="true" rel="nofollow" data-method="delete" href="/comments/' + v.id + '">Delete</a></span></div></div></div>'
          else
          string_result = '<div class="row comment-content-user"><div class="box-comment-user"><div class="wrapper-img"><img src="'+v.avatar+'"></div></div><div class="col-md-10 comment-content" name="'+v.id+'"><div class="comment-username">' + v.name +
          '</div><div class="comment-user-role">' + v.role + '</div><div class="comment-user-content">' + v.content + '</div><div class="form-hidden-comment"></div><div class="row"></div><div class="comment-control"><a class="mark-important" href="#"><input type="hidden" value="' + v.id + '"><span class="mark-important">Important</span></a></div></div></div>'
        else
          if (v.files != null)
            string_result = '<div class="row comment-content-user"><div class="box-comment-user"><div class="wrapper-img"><img src="'+v.avatar+'"></div></div><div class="col-md-10 comment-content" name="'+v.id+'"><div class="comment-username">' + v.name +
            '</div><div class="comment-user-role">' + v.role + '</div><div class="comment-user-content">' + v.content + '</div><div class="form-hidden-comment"></div><div class="row"><div class="col-md-4 img attachment add-attachment"><div class="wrapper-upload"><div class="image-upload"><img src="'+v.files+'"></div></div></div></div><div class="comment-control"><a class="mark-important" href="#"><input type="hidden" value="' + v.id + '"><span class="mark-important">Important</span></a></span>'
          else
            string_result = '<div class="row comment-content-user"><div class="box-comment-user"><div class="wrapper-img"><img src="'+v.avatar+'"></div></div><div class="col-md-10 comment-content" name="'+v.id+'"><div class="comment-username">' + v.name +
            '</div><div class="comment-user-role">' + v.role + '</div><div class="comment-user-content">' + v.content + '</div><div class="form-hidden-comment"></div><input type="hidden" value="' + v.id + '"><span class="mark-important">Important</span></a></span>'
      $('.comment-content-wrapper').append(string_result)
    });
  })
  //important
  $('span.mark-important').on('click', function() {
    AjaxImportant($(this))
  });
  //delete commnet
  $('span.delete-comment').find('a').on('click',function(){
    $(this).parent().parent().parent().remove()
  })
  // cap nhat lại check impotant
  $('.edit.edit-comment').on('click', function(){
    console.log('click roi nek');
    console.log($(this));
    editComment($(this));
  });
}

function AjaxSoftcomment(form) {
  $.ajax({
    type: "GET",
    url: "/comments/view_comments",
    dataType: "json",
    data: {
      "begin": 0,
      "end": 5,
      "important": $('#soft_commnet').val(),
      "id_todo": form.find('.comment_todo_id').find('input').val()
    },
    success: function(result) {
      AjaxComment(result);
    }
  });
}

function AjaxImportant(selector) {
    var comment_id = selector.parent().find('input').val()
  if (confirm("Do you want to make this comment important ?") == true) {
    $.ajax({
      url: '/comments/' + comment_id,
      type: 'PUT',
      data: {
        "important": selector.val(),
        "name": "importank",
        "id_todo": $('.comment_todo_id').find('input').val()
      }
    })
    selector.text('Important');
  }
}

  $('span.mark-important').on('click', function() {
    AjaxImportant($(this))
  });

  //delete comment
  $('span.delete-comment').find('a').on('click',function(){
    $(this).parent().parent().parent().parent().remove()
  });


$(document).ready(function() {
  //submit form commnet
  var form = $('#new_comment');
  form.find('.comment_content').keyup(function(e) {
    if (e.keyCode == 13) {
      // console.log(1);
      $('.col-md-10.box-comment-input.wrapper-attach-file-uploaded').remove()
        $("body").addClass("loading");
        setTimeout(function(){
          $('#new_comment').submit();
          $('#comment_content').val('')
          $('.comment-content-user').remove();
          // console.log(2);
        }, 3000)

        setTimeout(function(){
          $("body").removeClass("loading");
          AjaxSoftcomment(form)
        },4000)
    }
  });
  //sort comments
  $(".soft-comment").on('change', function() {
    $('.comment-content-user').remove();
      AjaxSoftcomment(form)
  });


  // //change form when click edit comment

  $('.edit.edit-comment').on('click', function(){
  var selector = $(this);
    editComment(selector);
  });
})

function editComment(selector){
  var form = $('#new_comment');
  var html_form_edit_comment = "<div class='row'>"+
                                  "<div class='col-md-12'>"+
                                    "<div class='input text required comment_content'>"+
                                      "<label class='text required' for='comment_content'></label>"+
                                      "<textarea class='comment-editing text required form-control' name='comment[content]' id='comment_content'></textarea>"+
                                    "</div>"+
                                  "</div>"+
                                  "<button id='save-comment-btn' class='btn speed-btn speed-comment-btn'> save </button>"+
                              "</div>";
  var current_val = selector.parents('.comment-content').find('.comment-user-content').text()
  console.log(current_val);
  selector.parents('.comment-content').find('.comment-user-content').text("");
  selector.parents('.comment-content').find('.comment-control').addClass('hide');
  selector.parents('.comment-content').find('.form-hidden-comment').append(html_form_edit_comment);
  selector.parents('.comment-content').find('#comment_content').val(current_val);
  SaveEdit(form)
}



function SaveEdit(form){
  $('#save-comment-btn').on('click', function() {
    $('.comment-content-user').remove();
    value = $(this).parent();
    id = value.parent().parent().attr('name')
    console.log(id);
    $.ajax({
      type: "PUT",
      url: "/comments/"+id,
      dataType: "json",
      data: {
        "content": value.find('.comment_content').find('textarea').val(),
        "name": "update-content",
        "id_todo": form.find('.comment_todo_id').find('input').val()
      },
      success: function(result) {
        AjaxComment(result)
      }
    })
  });
}
