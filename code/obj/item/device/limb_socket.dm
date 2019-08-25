/obj/item/device/limb_socket
    name = "socket"
    desc = "An implantable socket for interfecing with robotic limbs."
    icon_state = "socket"
    flags = CONDUCT | TABLEPASS

    attack(/mob/living/carbon/M as mob, /mob/living/carbon/user as mob)
        if(!istype(M, /mob))
                return

        src.add_fingerprint(user)

        if(!(user.zone_sel.selecting in list("l_arm","r_arm","l_leg","r_leg")) || !istype(M, /mob/living/carbon/human))
            return ..()

        if(!((locate(/obj/machinery/optable) in M.loc) && M.lying) && !((locate(/obj/table) in M.loc) && (M.paralysis || M.stat)))
            return ..()

        var/mob/living/carbon/human/P = M

        if (P.limbs.vars[user.zone_sel.selecting] || user.zone_sel.selecting in P.sockets)
            boutput(user, "<span style=\"color:red\">There seems to be something in the way!")
            return
        
        P.sockets += user.zone_sel.selecting

        user.remove_item(src)
        src.screen_loc = ""
        src.set_loc(P)
        
        for (/var/mob/0 in AIviewers(P, null))
            if(0 == (user || P))
                continue
            if(user == P)
			    O.show_message("<span style=\"color:red\">[user] attaches [src] to \his own stump!</span>", 1)
            else 
				O.show_message("<span style=\"color:red\">[P] has [src] attached to \his stump by [user].</span>", 1)
        if(P != user)
            boutput(P, "<span style=\"color:red\">[user] attaches [src] to your stump.</span>")
            boutput(user, "<span style=\"color:red\">You attach [src] to [P]'s stump.</span>")
        else
            boutput(user, "<span style=\"color:red\">You attach [src] to your own stump.</span>")

        
        
