`document.addEventListener("DOMContentLoaded", function(){
  // retrieving elements needed
   var comment_saveBtn=document.querySelector("#comment_saveBtn");
   var noThx=document.querySelectorAll(".noThx");
   var signUpModal=document.querySelector("#signUpModal");

  // Creating reset function to hide modal after user responds
   function reset(){
     event.preventDefault();
     signUpModal.style.display="none";
    //  signUpModal.style.z-index="1050";
     signUpModal.style.opacity="1";
   }

  // Adding Event Listener to each element found with noThx class
  for(count=0; count<noThx.length; count++){
    //Dismissing modal if user clicked "No Thanks"
    noThx[count].addEventListener("click", function(){
      event.preventDefault();
      var declined=true;
      reset();
      return declined;
    })
  }

  // Launching modal
   comment_saveBtn.addEventListener("click", function(){
     event.preventDefault();
     signUpModal.style.display="block";
    //  signUpModal.style.z-index="1050";
     signUpModal.style.opacity="1";
   })
 })`
