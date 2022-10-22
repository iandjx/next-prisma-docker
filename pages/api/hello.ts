// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import { PrismaClient } from '@prisma/client';
import type { NextApiRequest, NextApiResponse } from 'next'

type Data = {
  name: string
}

const prisma = new PrismaClient();

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  prisma.users.create({ data: { first_name: "joo", last_name: "baba" } }).then(res => console.log(res))
  res.status(200).json({ name: 'John Doe' })
}
