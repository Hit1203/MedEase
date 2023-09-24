// import { styles } from 'App.module.css'
import React, { Component } from 'react'

import { createBrowserRouter, RouterProvider } from 'react-router-dom'

import AdminPanel from './AdminPanel/AdminPanel'
import AdminPanelLogin from './AdminPanelLogin/AdminPanelLogin'
import Help from './Help/Help'
import PasswordReset from './PasswordReset/PasswordReset'

const router = createBrowserRouter([
  {
    path: 'change-forgotten-password/:token/',
    element: <PasswordReset />,
  },
  {
    path: '/',
    element: <div>BASE</div>,
  },
  {
    path: 'help/',
    element: <Help />,
  },
  {
    path: 'admin-panel/login/',
    element: <AdminPanelLogin />,
  },
  {
    path: 'admin-panel/',
    element: <AdminPanel />,
  },
])

export default class App extends Component {
  constructor(props) {
    super(props)
  }
  render() {
    return (
      <React.StrictMode>
        <RouterProvider router={router} />
      </React.StrictMode>
    )
  }
}
