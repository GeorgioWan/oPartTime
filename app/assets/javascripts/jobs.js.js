const FAVORITE_JOBS = "favorite_jobs";

function loadFavoriteJobs() {
  var jobs = Cookies.get(FAVORITE_JOBS);
  return jobs == null ? new Array() : JSON.parse(jobs);
}

function saveFavoriteJobs(jobs) {
  Cookies.set(FAVORITE_JOBS, JSON.stringify(jobs), { expires : 30 });
}

function addFavorite(jobId) {
  var jobs = loadFavoriteJobs();
  if (jobs.indexOf(jobId) == -1) {
    jobs.push(jobId);
    saveFavoriteJobs(jobs);
  }
}

function removeFavorite(jobId) {
  var jobs = loadFavoriteJobs();
  var index = jobs.indexOf(jobId);
  if (index != -1) {
    jobs.splice(index, 1);
    saveFavoriteJobs(jobs);
  }
}

$(document).ready(function() {
  $(".mdi-action-favorite").on("click", function() {
    addFavorite($(this).attr("jobid"));
  });
});