# OPS-002 - TaskFlow Service Incident

## Incident Summary
- Service: taskflow-training.service
- Reported Problem: The training service failed to start and returend an exit code = 1
- Environment: AWS EC2 t3.micro, Ubuntu 24.04LT, Taskflow development server

## Investigation
- Initial Service Status: failed (Result: exit-code)
- Relevant Error: ExecStart=/usr/bin/test -f /tmp/taskflow-training-ready
status=1/FAILURE
- Commands Used: 
	* systemctl status taskflow-training --no-paher -1 = Inspected the failed service
	* sudo jorunalctl -u taskflow-training -n 15 --no-pager = Reviewed service logs
	* ls -l /tmp/taskflow-training-ready = Checked whether the required file existed

## Root Cause
- The service was configured to check for the file /tmp/taskflow-training-ready during startup.
- The file did not exist, causing /usr/bin/test -f to return exit code 1. As a result, systemd marked the service as failed.

## Resolution
- Created the missing file using sudo touch /tmp/taskflow-training-ready
- Verified the file existed using ls -l
- Started the service again using sudo systemctl start taskflow-training

## Verification
- The service successfully completed its task after missing file was created
- The system journal confirmed:
	* Deactivated successfully.
	* Finished taskflow-training.service - TaskFlow Training Service
- The final service status was inactive (dead), which is expected for this Type=oneshot service after successful execution.

## Lessons Learned
- Use systemctl status to identify the service failures
- Use journalctl to investigate service logs
- Verify the suspected root cause before applying a fix
- A non-zero exit code generally indicated failure.
- inactive (dead) dooes not always mean a service is broken; its expected behavior depends on its configuration.
- Verify that a service works after applying a fix
