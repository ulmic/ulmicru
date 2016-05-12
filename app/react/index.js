import RWR, { integrationsManager } from 'react-webpack-rails';
import RWRRedux from 'rwr-redux';

RWR.run();

integrationsManager.register('redux-store', RWRRedux.storeIntegrationWrapper);
integrationsManager.register('redux-container', RWRRedux.containerIntegrationWrapper);

import TagsForm from '../assets/javascripts/web/admin/tags/form'
RWR.registerComponent('TagsForm', TagsForm)
