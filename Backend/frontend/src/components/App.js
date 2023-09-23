// import { styles } from 'App.module.css'
import React, { Component } from 'react'

import { createBrowserRouter, RouterProvider } from 'react-router-dom'

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
