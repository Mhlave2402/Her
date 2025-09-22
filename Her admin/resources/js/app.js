require('./bootstrap');

import {createApp} from 'vue';
import NannyManagement from './components/NannyManagement.vue';

const app = createApp({});

app.component('nanny-management', NannyManagement);

app.mount('#app');

window.Echo.private('admin')
    .listen('SOSAlert', (e) => {
        alert('SOS received from user: ' + e.sos.user_id);
    });
