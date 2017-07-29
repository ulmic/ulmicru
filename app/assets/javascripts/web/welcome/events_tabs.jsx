import React from 'react'
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs'

class EventsTabs extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    return(
      <Tabs>
        <TabList>
          <Tab>First</Tab>
        </TabList>
        <TabPanel>
          <div dangerouslySetInnerHTML={{ __html: this.props.eventTab  }} />
        </TabPanel>
      </Tabs>
    )
  }
}

export default EventsTabs
