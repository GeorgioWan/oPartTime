readURL = (input) ->
  if input.files and input.files[0]
    reader = new FileReader

    reader.onload = (e) ->
      $('.preveiw').attr 'src', e.target.result

    reader.readAsDataURL input.files[0]
  return

$ ->
  $('#img-input').change ->
    readURL this
    return