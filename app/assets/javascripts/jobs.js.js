const FAVORITE_JOBS = "favorite_jobs";
const IS_LOGIN = "is_login";

function isLoggedin() {
  return Cookies.get(IS_LOGIN) != null && Cookies.get(IS_LOGIN) == "true"
}

function loadFavoriteJobs() {
  var jobs = Cookies.get(FAVORITE_JOBS);
  return jobs == null ? new Array() : JSON.parse(jobs);
}

function saveFavoriteJobs(jobs) {
  Cookies.set(FAVORITE_JOBS, JSON.stringify(jobs), { expires : 30 });
}

function addFavorite(jobId) {
  if (isLoggedin()) {
    $.ajax({
      method: "POST",
      url: "/user/favorite",
      data: { jobId: jobId }
    });
  } else {
    var jobs = loadFavoriteJobs();
    if (jobs.indexOf(jobId) == -1) {
      jobs.push(jobId);
      saveFavoriteJobs(jobs);
    }
  }
}

function removeFavorite(jobId) {
  if (isLoggedin()) {
    $.ajax({
      method: "DELETE",
      url: "/user/favorite",
      data: { jobId: jobId }
    });
  } else {
    var jobs = loadFavoriteJobs();
    var index = jobs.indexOf(jobId);
    if (index != -1) {
      jobs.splice(index, 1);
      saveFavoriteJobs(jobs);
    }
  }
}

$(document).ready(function() {
  $(".fa-btn").on("click", function() {
    var jobId = $(this).attr("jobid");
    if ($(this).hasClass("favorite")) 
      addFavorite(jobId);
    else
      removeFavorite(jobId);
    $(".fa-btn[jobid=" + jobId + "]").toggleClass("favorite").toggleClass("unfavorite");
  });
});