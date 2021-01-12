/**
 * KeeWeb plugin: oauth2-plugin
 * @author Martin Pouliot
 * @license MIT
 */

const ViewModule = require('views/app-view');
const AppView = ViewModule.AppView;
const lockWorkspace = AppView.prototype.lockWorkspace;
console.log("OAuth2-plugin loaded!");

AppView.prototype.lockWorkspace = function (autoInit) {
    lockWorkspace.apply(this,[autoInit]);
    
    setTimeout(() => {
        window.location.href = "/oauth2/sign_out";
    }, 500);
}

module.exports.uninstall = function() {
    AppView.prototype.lockWorkspace = lockWorkspace;
};