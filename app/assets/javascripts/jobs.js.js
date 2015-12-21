const FAVORITE_JOBS = "favorite_jobs";
const IS_LOGIN = "is_login";
var jobBackup_list = new Array();
var preUndoMsgSnackbar = null;

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

function undoUnfavortie() {
  var job = jobBackup_list.pop();
  var domContainer = $("ul#job-index-list");
  if (job.index >= domContainer.children().length)
    job.dom.appendTo(domContainer);
  else
    job.dom.insertBefore(domContainer.children()[job.index]);
  
  addFavorite(job.id);
  job.dom.show('fast');
}

function storeAndRemoveJob(jobId) {
  var job = new Object();
  job.id = jobId;
  job.dom = $("li.list-group-item[jobId=" + jobId + "]")
  job.index = job.dom.index();
  job.dom.hide('fast', function(){ job.dom.remove(); });
  jobBackup_list.push(job);
}

function showUndoFJSnackbar() {
  if (preUndoMsgSnackbar != null)
    preUndoMsgSnackbar.remove();
  var options =  {
    content: '<span>你剛剛移除了 1 個喜歡的工作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><a class="undo-unfavorite" style="text-decoration: none;">ლ(́◉◞౪◟◉‵ლ) 復原</a>', // text of the snackbar
    style: "snackbar", // add a custom class to your snackbar
    timeout: 10 * 1000, // time in milliseconds after the snackbar autohides, 0 is disabled
    htmlAllowed: true // allows HTML as content value
  }
  preUndoMsgSnackbar = $.snackbar(options);
  preUndoMsgSnackbar.on("click", ".undo-unfavorite", function() {
    undoUnfavortie();
  });
  return preUndoMsgSnackbar;
}

function favoriteButtonClickAnimate(btn){
  btn.animate({ turn: '+=180' }, {
    step: function(now,fx) {
      btn.css('transform',"rotateY(" + now + "deg)");
    },
    duration:'normal'
  },'linear');
}

function listMenuButtonClickAnimate(btn){
  var elem = btn.parents("span").children("span");
  
  if (!elem.is(':visible'))  {
    btn.animate({ turn: '90' }, {
      step: function(now,fx) {
        btn.css('transform',"rotate(" + now + "deg)");
      },
      duration:'fast'
    },'ease');
  } else {
    btn.animate({ turn: '0' }, {
      step: function(now,fx) {
        btn.css('transform',"rotate(" + now + "deg)");
      },
      duration:'fast'
    },'ease');
  }
  
  elem.children("#job-index-list-edit").toggleClass("showE").toggleClass("hideE");
  elem.children("#job-index-list-delete").toggleClass("showD").toggleClass("hideD");
  elem.fadeToggle('fast', function(){});
  
}

$(document).ready(function() {
  $("ul.panel.list-group").on("click", ".fa-btn", function() {
    var jobId = $(this).attr("jobid");
    favoriteButtonClickAnimate($(this));
    $(this).blur();
    if ($(this).hasClass("favorite")) {
      addFavorite(jobId);
      $(this).attr("data-original-title", "從最愛清單中移除!");
      $(".fa-btn[jobid=" + jobId + "]").toggleClass("favorite").toggleClass("unfavorite");
    } else {
      removeFavorite(jobId);
      if ($(this).parents("li.list-group-item").attr("isremoveable") == "true") {
        storeAndRemoveJob(jobId);
        showUndoFJSnackbar();
        $("#"+$(this).attr("aria-describedby")).remove(); // remove tooltip when this list remove
      } else {
        $(this).attr("data-original-title", "加入最愛!");
        $(".fa-btn[jobid=" + jobId + "]").toggleClass("favorite").toggleClass("unfavorite");
      }
    }
  });
  
  $("ul.panel.list-group").on("click", "#job-index-list-ud", function() {
    var jobId = $(this).attr("jobid");
    listMenuButtonClickAnimate($(this));
  });
});
