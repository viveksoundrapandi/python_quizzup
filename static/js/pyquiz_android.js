function show_spinner()
{
   spinnerplugin.show();
}
function hide_spinner()
{
   spinnerplugin.hide();
}

document.addEventListener("deviceready", onDeviceReady, false);
function onDeviceReady() 
{
    hide_spinner();

}
$(document).ready(function()
{
   $("body").on("click", ".spinner", show_spinner);
});

