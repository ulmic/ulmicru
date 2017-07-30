import React from 'react'
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs'

class EventsTabs extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    return(
      <Tabs selectedTabClassName="active">
        <TabList className="tabs" data-tab="data-tab">
          <Tab className="tab-title">
            <a href="#">
              First
            </a>
          </Tab>
          <Tab className="tab-title">
            <a href="#">
              Second
            </a>
          </Tab>
        </TabList>
        <TabPanel>
          <div dangerouslySetInnerHTML={{ __html: this.props.eventTab  }} />
        </TabPanel>
        <TabPanel>
          GBLH
        </TabPanel>
      </Tabs>
    )
  }
}

export default EventsTabs
