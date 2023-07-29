#!/bin/bash

set_db2codepage() {
  db2set DB2CODEPAGE=1208
  db2stop
  db2start
}

set_db2codepage
