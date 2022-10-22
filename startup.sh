#!/bin/bash
node prisma migrate deploy
node server.js:w
