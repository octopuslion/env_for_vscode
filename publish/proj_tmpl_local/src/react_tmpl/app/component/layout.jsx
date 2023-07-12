import React from 'react';
import Config from '../config/app.js';
import RequestUtil from '../util/request_util.js';
import LayoutStyle from '../style/layout.module.less';

class Layout extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            text: null,
        };
    }

    componentDidMount() {
        this._requestText(1);
    }

    render() {
        return (
            <div className={`${LayoutStyle.layoutRoot} ${LayoutStyle.backgroundImageCenter}`}>
                {this._renderText(this.state.text)}
            </div>
        );
    }

    _renderText = (text) => {
        if (text === null || text === undefined) {
            return;
        }

        return <label>{text}</label>;
    };

    _requestText = (id) => {
        const baseUrl = Config.get('baseUrl');
        RequestUtil.httpGetAsync(`${baseUrl}/text/${id}`, [['accept', '*/*']])
            .then((textJson) => {
                const text = JSON.parse(textJson)['text'];
                this.setState({
                    text: text,
                });
            })
            .catch(() => {});
    };
}

export default Layout;
