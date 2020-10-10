#!/usr/bin/env python

class Solution(object):

    def insertIntoBST(self, root, val):
        """
        :type root: TreeNode
        :type val: int
        :rtype: TreeNode
        """
        l = len(root)

        def insert_at(idd):
            if idd > l:
                for i in range(l, idd):
                    root.append(None)
                root.append(val)
            else:
                root[idd] = val

        def get(idd):
            if idd < l:
                return root[idd]
            else:
                return None

        def insert_under(parent):
            if val < get(parent):
                left_id = parent*2+1
                if get(left_id):
                    insert_under(left_id)
                else:
                    insert_at(left_id)
            else:
                right_id = parent*2+2
                if get(right_id):
                    insert_under(right_id)
                else:
                    insert_at(right_id)

        insert_under(0)
        return root


s = Solution()
print(s.insertIntoBST([40, 20, 60, 10, 30, 50, 70], 25))
