import React from 'react';
import { createRoot } from 'react-dom/client';
import Layout from './component/layout.jsx';

React.Component.prototype.$env = 'dev';
const root = createRoot(document.getElementById('root'));
root.render(<Layout />);
