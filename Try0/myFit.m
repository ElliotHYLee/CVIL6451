function[spList_cd, spList_md, cs, spList_ms] = myFit(spList_obs, spList_cd, spList_md, cs_val, spList_ms, N)
    cs = cs_val;
    for spIndex = 1:1:N
        % get mD and mD^2 sums
        md = spList_md{spIndex}; %(n,1)
        ms = spList_ms{spIndex}; %(n,1)
        obs = spList_obs{spIndex};
        ld = -ms*cs + obs; %(n,3)
        cd = md'*ld/sum(md.*2);
        spList_cd{spIndex} = makeSpList_cd(spList_cd{spIndex}, cd); % save new cd
 
        md = (cd*ld')'/ (cd*cd');
        spList_md{spIndex} = md; % save new md
    end
    
    nom = 0;
    denom = 0;
    for spIndex = 1:1:N
        md = spList_md{spIndex}; %(n,1)
        ms = spList_ms{spIndex}; %(n,1)
        cd = spList_cd{spIndex}; %(n,3) 
        cd = cd(1,:); %(1,3) 
        obs = spList_obs{spIndex};
        nom = nom + (ms'*(-md*cd + obs))';
        denom = denom + (ms'*ms);
    end
    cs = (nom/denom)';

    for spIndex = 1:1:N
        md = spList_md{spIndex}; %(n,1)
        cd = spList_cd{spIndex}; %(n,3) 
        cd = cd(1,:); %(1,3) 
        obs = spList_obs{spIndex};
        ms = ((-md*cd + obs)*cs')/(cs*cs');
        spList_ms{spIndex} = ms;
    end
    
end