import React from 'react';

class App {
    constructor() {}

    static get(name) {
        if (App.config === undefined) {
            const app = new App();
            App.config = app._config();
            if (React.Component.prototype.$env === 'dev') {
                Object.assign(App.config, app._config_dev());
            }
        }

        return App.config[name];
    }

    _config = () => {
        return {
            baseUrl: 'http://*.*.*.*:8080',
        };
    };

    _config_dev = () => {
        return {
            baseUrl: 'http://localhost:8080',
        };
    };
}

export default App;
