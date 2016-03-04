# Solve the turbolinks problem
# issue: https://github.com/spohlenz/tinymce-rails/issues/145#issuecomment-49307568
$(document).on 'page:receive', ->
  tinymce.remove()